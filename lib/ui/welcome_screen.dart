import 'package:atomik_spor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

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
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              final cardPadding = EdgeInsets.symmetric(
                horizontal: isWide ? 48 : 28,
                vertical: isWide ? 48 : 36,
              );

              Widget buildBadge() {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
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
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x0F132442),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 20,
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
                );
              }

              Widget buildCtaButton() {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/habitTracker');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2EC173),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      textStyle: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: Text(l10n.welcomeCta),
                  ),
                );
              }

              Widget buildTextColumn() {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  children: [
                    buildBadge(),
                    const SizedBox(height: 24),
                    Text(
                      l10n.welcomeBrand,
                      textAlign: isWide ? TextAlign.left : TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                            letterSpacing: 1.5,
                            color: const Color(0xFF132442),
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.welcomeGreeting,
                      textAlign: isWide ? TextAlign.left : TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF3B4D68),
                          ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      l10n.welcomeTagline,
                      textAlign: isWide ? TextAlign.left : TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            height: 1.5,
                            color: const Color(0xFF52607A),
                          ),
                    ),
                    const SizedBox(height: 24),
                    buildHighlights(),
                    const SizedBox(height: 32),
                    buildCtaButton(),
                  ],
                );
              }

              Widget buildImage() {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30),
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
                      child: Image.asset(
                        'assets/images/giris1.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                );
              }

              Widget buildCard() {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isWide ? 1100 : 520),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(36),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x143062C8),
                          blurRadius: 60,
                          offset: Offset(0, 32),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: cardPadding,
                      child: isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: buildTextColumn()),
                                const SizedBox(width: 48),
                                Expanded(child: buildImage()),
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
                );
              }

              final card = buildCard();

              if (isWide) {
                return Center(child: card);
              }

              return Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: card,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
