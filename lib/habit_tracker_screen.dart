import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:atomik_spor/ui/widgets/chain_day.dart';

import 'package:atomik_spor/data/session_repo.dart';
import 'package:atomik_spor/domain/streak.dart';
import 'package:atomik_spor/logic/streak_service.dart';

class HabitTrackerScreen extends StatefulWidget {
  const HabitTrackerScreen({super.key});

  @override
  State<HabitTrackerScreen> createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  static const List<String> _habitIds = <String>[
    'morningStretch',
    'reading',
    'hydrate',
  ];

  final Map<DateTime, Set<String>> _completedHabits = <DateTime, Set<String>>{};

  final _service = StreakService(SessionRepo());
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    _selectedDay = today;
    _focusedDay = today;
  }

  void _toggleHabit(String habitId, bool isCompleted) {
    final DateTime? selectedDay = _selectedDay;
    if (selectedDay == null) {
      return;
    }

    final DateTime dayKey = DateUtils.dateOnly(selectedDay);

    setState(() {
      final Set<String> completedForDay =
          _completedHabits.putIfAbsent(dayKey, () => <String>{});
      if (isCompleted) {
        completedForDay.add(habitId);
      } else {
        completedForDay.remove(habitId);
        if (completedForDay.isEmpty) {
          _completedHabits.remove(dayKey);
        }
      }

      if (completedForDay.length == _habitIds.length) {
        _service.repo.markCompleted(dayKey);
      } else {
        _service.repo.unmark(dayKey);
      }
    });
  }

  String _habitLabel(String habitId, AppLocalizations l10n) {
    switch (habitId) {
      case 'morningStretch':
        return l10n.habitMorningStretch;
      case 'reading':
        return l10n.habitReading;
      case 'hydrate':
        return l10n.habitHydrate;
    }
    return habitId;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final l10n = AppLocalizations.of(context)!;
    final calendarLocale = switch (locale.languageCode) {
      'tr' => 'tr_TR',
      'en' => 'en_US',
      _ => locale.toLanguageTag().replaceAll('-', '_'),
    };

    final DateTime? selectedDay = _selectedDay;
    final DateTime? selectedDayKey =
        selectedDay != null ? DateUtils.dateOnly(selectedDay) : null;
    final Set<String> completedForDay = selectedDayKey != null
        ? _completedHabits[selectedDayKey] ?? <String>{}
        : <String>{};
    final int completedCount = completedForDay.length;
    final int totalHabits = _habitIds.length;
    final String? formattedDate = selectedDay != null
        ? DateFormat.yMMMMd(l10n.localeName).format(selectedDay)
        : null;
    final String listTitle = formattedDate != null
        ? '${l10n.habitListTitle} · $formattedDate'
        : l10n.habitListTitle;

    final month = DateTime(_focusedDay.year, _focusedDay.month);
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    int startOffset = firstDayOfMonth.weekday - DateTime.monday;
    if (startOffset < 0) startOffset += 7;
    final firstVisible = firstDayOfMonth.subtract(Duration(days: startOffset));
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    int endOffset = DateTime.sunday - lastDayOfMonth.weekday;
    if (endOffset < 0) endOffset += 7;
    final lastVisible = lastDayOfMonth.add(Duration(days: endOffset));

    final completedDays =
        _service.repo.allCompleted().map(DateUtils.dateOnly).toSet();
    final visuals = buildMonthVisuals(
      completedDays,
      firstDay: firstVisible,
      lastDay: lastVisible,
      month: month,
      today: DateTime.now(),
    );
    Widget buildCell(DateTime day) {
      final visual = visuals[DateUtils.dateOnly(day)];
      if (visual == null) {
        return const SizedBox.shrink();
      }
      return ChainDay(v: visual);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.habitTrackerTitle),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: calendarLocale,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = DateUtils.dateOnly(selectedDay);
                _focusedDay = DateUtils.dateOnly(focusedDay);
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = DateUtils.dateOnly(focusedDay);
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) => buildCell(day),
              outsideBuilder: (context, day, focusedDay) => buildCell(day),
              todayBuilder: (context, day, focusedDay) => buildCell(day),
              selectedBuilder: (context, day, focusedDay) => buildCell(day),
            ),
            calendarStyle: const CalendarStyle(
              cellMargin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.habitCompletionSummary(
                    completedCount,
                    totalHabits,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.habitInstructions,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: totalHabits,
              itemBuilder: (context, index) {
                final String habitId = _habitIds[index];
                final bool isCompleted = completedForDay.contains(habitId);
                return CheckboxListTile(
                  key: Key('habitCheckbox_$habitId'),
                  value: isCompleted,
                  onChanged: (value) =>
                      _toggleHabit(habitId, value ?? !isCompleted),
                  title: Text(_habitLabel(habitId, l10n)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
