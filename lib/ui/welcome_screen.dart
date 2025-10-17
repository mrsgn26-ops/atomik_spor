import 'package:atomik_spor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
    required this.onStartPressed,
    required this.onChangeLanguage,
  });

  final VoidCallback onStartPressed;
  final VoidCallback onChangeLanguage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF6FBFF), Color(0xFFE6F0FF)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  key: const Key('changeLanguageButton'),
                  onPressed: onChangeLanguage,
                  icon: const Icon(Icons.language),
                  label: Text(l10n.btnChangeLang),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _WelcomeCard(l10n: l10n),
                          const SizedBox(height: 24),
                          FilledButton(
                            key: const Key('showCalendarButton'),
                            onPressed: onStartPressed,
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Text(
                              l10n.welcomeCta,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 16),
            blurRadius: 40,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.welcomeBrand,
            style: theme.textTheme.labelLarge?.copyWith(
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.welcomeWizard,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 28),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.welcomeGreeting,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.welcomeTagline,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              _WelcomeIllustration(l10n: l10n),
            ],
          ),
        ],
      ),
    );
  }
}

class _WelcomeIllustration extends StatelessWidget {
  const _WelcomeIllustration({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 140,
      height: 170,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary.withOpacity(0.8), colorScheme.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 24,
            child: _IllustratedAvatar(
              backgroundColor: Colors.white,
              icon: Icons.fitness_center,
              iconColor: colorScheme.primary,
            ),
          ),
          Positioned(
            right: 12,
            bottom: 28,
            child: _IllustratedAvatar(
              backgroundColor: Colors.white.withOpacity(0.9),
              icon: Icons.self_improvement,
              iconColor: colorScheme.primary,
            ),
          ),
          Positioned(
            left: 24,
            bottom: 16,
            child: _ChainDecor(color: Colors.white.withOpacity(0.75)),
          ),
          Positioned(
            right: -6,
            top: -12,
            child: _DurationPill(
              text: l10n.welcomeDuration,
              color: Colors.white,
              foreground: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _IllustratedAvatar extends StatelessWidget {
  const _IllustratedAvatar({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
  });

  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: 28),
    );
  }
}

class _ChainDecor extends StatelessWidget {
  const _ChainDecor({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        return Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

class _DurationPill extends StatelessWidget {
  const _DurationPill({
    required this.text,
    required this.color,
    required this.foreground,
  });

  final String text;
  final Color color;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.timer_outlined, size: 18, color: foreground),
            const SizedBox(width: 6),
            Text(
              text,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: foreground,
                  ) ??
                  TextStyle(
                    fontWeight: FontWeight.w700,
                    color: foreground,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
