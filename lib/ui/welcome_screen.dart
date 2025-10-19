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
        final isWide = constraints.maxWidth > 720;
        final cardPadding = isWide
            ? const EdgeInsets.symmetric(horizontal: 48, vertical: 56)
            : const EdgeInsets.symmetric(horizontal: 32, vertical: 44);

        final headlineStyle = theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w800,
          fontSize: isWide ? 34 : 28,
          color: const Color(0xFF14213D),
          letterSpacing: 1.2,
        );

        final subtitleStyle = theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: isWide ? 18 : 16,
          letterSpacing: 5,
          color: const Color(0xFF5D6A85),
        );

        final bodyStyle = theme.textTheme.bodyLarge?.copyWith(
          fontSize: isWide ? 18 : 16,
          height: 1.5,
          color: const Color(0xFF6B738C),
        );

        Widget buildTextColumn() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.welcomeBrand,
                style: headlineStyle,
              ),
              const SizedBox(height: 8),
              Text(
                localizations.welcomeWizard.toUpperCase(),
                style: subtitleStyle,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F8EF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2EC173),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        localizations.welcomeGreeting,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: isWide ? 26 : 22,
                          color: const Color(0xFF1F2A44),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                localizations.welcomeTagline,
                style: bodyStyle,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/habitTracker');
                },
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
                  textStyle: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(localizations.welcomeCta),
                    const SizedBox(width: 12),
                    const Icon(Icons.arrow_forward_rounded),
                  ],
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/giris1.jpg'),
                ),
              ),
            ),
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWide ? 980 : 520),
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
                padding: cardPadding,
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
