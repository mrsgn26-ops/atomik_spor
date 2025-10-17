import 'dart:math' as math;

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
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Color(0x143062C8),
                blurRadius: 45,
                offset: Offset(0, 28),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ATOMİK SPOR',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: const Color(0xFF182A49),
                      letterSpacing: 4,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'KURULUM SİHİRBAZI',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 6,
                      color: const Color(0xFF5B6B81),
                    ),
              ),
              const SizedBox(height: 24),
              const _Illustration(),
              const SizedBox(height: 32),
              Text(
                'Hoş geldiniz!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: const Color(0xFF182A49),
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hedefleri unut, sistem kur.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      color: const Color(0xFF6E7A93),
                    ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2EC173),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Sistemini Kuralım',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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

class _Illustration extends StatelessWidget {
  const _Illustration();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final chainLinkWidth = constraints.maxWidth / 5;
          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                bottom: 0,
                child: _PersonCard(
                  size: math.min(constraints.maxWidth * 0.55, 180),
                  colors: const [Color(0xFFE6F8EF), Color(0xFFB6F0D0)],
                  icon: Icons.fitness_center,
                  iconColor: const Color(0xFF25472C),
                ),
              ),
              Positioned(
                right: constraints.maxWidth * 0.08,
                bottom: 0,
                child: _PersonCard(
                  size: math.min(constraints.maxWidth * 0.42, 140),
                  colors: const [Color(0xFFF3E9FF), Color(0xFFE0D5FF)],
                  icon: Icons.directions_run,
                  iconColor: const Color(0xFF3A2B5E),
                ),
              ),
              Positioned(
                top: constraints.maxHeight * 0.2,
                left: chainLinkWidth * 0.6,
                right: chainLinkWidth * 0.6,
                child: _ChainLinks(width: constraints.maxWidth - chainLinkWidth * 1.2),
              ),
              Positioned(
                right: 0,
                top: constraints.maxHeight * 0.1,
                child: const _TimerBadge(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({
    required this.size,
    required this.colors,
    required this.icon,
    required this.iconColor,
  });

  final double size;
  final List<Color> colors;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size * 0.72,
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.18,
        vertical: size * 0.14,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      child: FittedBox(
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}

class _ChainLinks extends StatelessWidget {
  const _ChainLinks({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    const linkColor = Color(0xFF32C87A);
    final linkCount = 4;
    final linkWidth = width / linkCount;
    final linkHeight = linkWidth * 0.45;

    return SizedBox(
      height: linkHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          linkCount,
          (index) => Transform.rotate(
            angle: index.isOdd ? -0.2 : 0.2,
            child: Container(
              width: linkWidth * 0.92,
              height: linkHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(linkHeight / 2),
                border: Border.all(color: linkColor, width: 4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerBadge extends StatelessWidget {
  const _TimerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F9EF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF32C87A), width: 3),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.timer, color: Color(0xFF32C87A), size: 28),
          SizedBox(height: 4),
          Text(
            '6 dk',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xFF1D3B2B),
            ),
          ),
        ],
      ),
    );
  }
}
