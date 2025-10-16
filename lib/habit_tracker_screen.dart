import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    });
  }

  String _habitLabel(String habitId, AppLocalizations localizations) {
    switch (habitId) {
      case 'morningStretch':
        return localizations.habitMorningStretch;
      case 'reading':
        return localizations.habitReading;
      case 'hydrate':
        return localizations.habitHydrate;
    }
    return habitId;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final localizations = AppLocalizations.of(context)!;
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
        ? DateFormat.yMMMMd(localizations.localeName).format(selectedDay)
        : null;
    final String listTitle = formattedDate != null
        ? '${localizations.habitListTitle} · $formattedDate'
        : localizations.habitListTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.habitTrackerTitle),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: calendarLocale,
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
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
                  localizations.habitCompletionSummary(
                    completedCount,
                    totalHabits,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  localizations.habitInstructions,
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
                  title: Text(_habitLabel(habitId, localizations)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
