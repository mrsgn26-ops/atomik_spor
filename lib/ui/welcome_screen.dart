import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFF5FAFF), Color(0xFFFFFFFF)],
          ),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: _WelcomeCard(),
          ),
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 640;
        final textAlign = isWide ? TextAlign.left : TextAlign.center;
        final crossAxisAlignment =
            isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center;

        Widget buildBadge() {
          return Align(
            alignment: isWide ? Alignment.centerLeft : Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0x112EC173),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.auto_fix_high_rounded,
                    size: 18,
                    color: Color(0xFF2EC173),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.welcomeWizard.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.6,
                      color: const Color(0xFF2EC173),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        Widget buildHighlights() {
          final items = [
            _HighlightItem(
              icon: Icons.auto_graph_rounded,
              label: 'Atomic habits in action',
            ),
            _HighlightItem(
              icon: Icons.bolt_rounded,
              label: 'Quick, focused setup',
            ),
            _HighlightItem(
              icon: Icons.task_alt_rounded,
              label: 'Track progress daily',
            ),
          ];

          return Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment:
                isWide ? WrapAlignment.start : WrapAlignment.center,
            children: items,
          );
        }

        Widget buildTextColumn() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              buildBadge(),
              const SizedBox(height: 24),
              Text(
                l10n.welcomeBrand,
                textAlign: textAlign,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: isWide ? 36 : 32,
                  letterSpacing: 1.5,
                  color: const Color(0xFF132442),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.welcomeGreeting,
                textAlign: textAlign,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3B4D68),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.welcomeTagline,
                textAlign: textAlign,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  height: 1.5,
                  color: const Color(0xFF52607A),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0x0F132442),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 18,
                      color: Color(0xFF132442),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.welcomeDuration,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: const Color(0xFF132442),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              buildHighlights(),
              const SizedBox(height: 32),
              SizedBox(
                width: isWide ? null : double.infinity,
                child: ElevatedButton.icon(
                  key: const Key('showCalendarButton'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/habitTracker');
                  },
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(
                    l10n.welcomeCta,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2EC173),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 24,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        Widget buildImage() {
          return ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: AspectRatio(
              aspectRatio: isWide ? 4 / 3 : 3 / 4,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFEFF7FF), Color(0xFFFFFFFF)],
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/giris1.jpg'),
                ),
              ),
            ),
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWide ? 960 : 520),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x123062C8),
                    blurRadius: 60,
                    offset: Offset(0, 32),
                  ),
                ],
              ),
              child: Padding(
                padding: isWide
                    ? const EdgeInsets.symmetric(horizontal: 48, vertical: 56)
                    : const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                child: isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 3, child: buildTextColumn()),
                          const SizedBox(width: 40),
                          Expanded(flex: 4, child: buildImage()),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildImage(),
                          const SizedBox(height: 32),
                          buildTextColumn(),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HighlightItem extends StatelessWidget {
  const _HighlightItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0x0F132442),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF132442),
            ),
          ),
        ],
      ),
    );
  }
}
