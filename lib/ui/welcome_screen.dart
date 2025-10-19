import 'package:atomik_spor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _WelcomeBackground(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: _WelcomeCard(),
          ),
        ),
      ),
    );
  }
}

class _WelcomeBackground extends StatelessWidget {
  const _WelcomeBackground({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFFF5FAFF), Color(0xFFFFFFFF)],
        ),
      ),
      child: child,
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 620;
        final cardPadding = EdgeInsets.symmetric(
          horizontal: isWide ? 48 : 28,
          vertical: isWide ? 48 : 32,
        );

        Widget buildChip() {
          return Container(
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
                  localizations.welcomeWizard.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.6,
                        color: const Color(0xFF2EC173),
                      ),
                ),
              ],
            ),
          );
        }

        Widget buildTextColumn() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              if (isWide) buildChip(),
              if (isWide) const SizedBox(height: 20),
              Text(
                localizations.welcomeBrand,
                textAlign: isWide ? TextAlign.start : TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 32,
                      letterSpacing: 1.4,
                      color: const Color(0xFF132442),
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                localizations.welcomeGreeting,
                textAlign: isWide ? TextAlign.start : TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B4D68),
                    ),
              ),
              const SizedBox(height: 20),
              Text(
                localizations.welcomeTagline,
                textAlign: isWide ? TextAlign.start : TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      height: 1.6,
                      color: const Color(0xFF52607A),
                    ),
              ),
              const SizedBox(height: 24),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0x0F132442),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      size: 20,
                      color: Color(0xFF132442),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        localizations.welcomeDuration,
                        style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: const Color(0xFF132442),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Align(
                alignment:
                    isWide ? Alignment.centerLeft : Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/habitTracker');
                  },
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(localizations.welcomeCta),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2EC173),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                    textStyle: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                  ),
                ),
              ),
            ],
          );
        }

        Widget buildImage() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isWide) ...[
                buildChip(),
                const SizedBox(height: 20),
              ],
              ClipRRect(
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
              ),
            ],
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWide ? 920 : 520),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x143062C8),
                    blurRadius: 55,
                    offset: Offset(0, 28),
                  ),
                ],
              ),
              child: Padding(
                padding: cardPadding,
                child: isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 3, child: buildTextColumn()),
                          const SizedBox(width: 48),
                          Expanded(flex: 4, child: buildImage()),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
