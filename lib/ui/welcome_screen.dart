import 'dart:math' as math;

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _WelcomeBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final minHeight = math.max(0.0, constraints.maxHeight - 96);
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: minHeight),
                  child: const Center(
                    child: _WelcomeCard(),
                  ),
                ),
              );
            },
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final illustrationHeight = math.min(width * 1.25, 340.0);
        final femaleHeight = math.min(
          math.min(width * 0.95, illustrationHeight * 0.9),
          220.0,
        );
        final maleWidth = math.min(width * 0.88, 220.0);
        return SizedBox(
          height: illustrationHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: width * 0.9,
                  height: width * 0.08,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x1A1B3B2B), Color(0x101B3B2B)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                  ),
                ),
              ),
              Positioned(
                top: width * 0.12,
                left: width * 0.12,
                right: width * 0.12,
                child: SizedBox(
                  height: width * 0.26,
                  child: const _ChainLinks(),
                ),
              ),
              Positioned(
                top: 0,
                right: width * 0.02,
                child: const _TimerBadge(),
              ),
              Positioned(
                bottom: -width * 0.08,
                left: width * 0.02,
                child: _FemaleAthlete(height: femaleHeight),
              ),
              Positioned(
                bottom: -width * 0.04,
                right: width * 0.02,
                child: _MaleAthlete(width: maleWidth),
              ),
              Positioned(
                left: width * 0.08,
                bottom: width * 0.02,
                child: SizedBox(
                  width: width * 0.22,
                  height: width * 0.12,
                  child: const _Dumbbell(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChainLinks extends StatelessWidget {
  const _ChainLinks();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ChainPainter(),
    );
  }
}

class _ChainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linkColor = const Color(0xFF34C67C);
    final strokeWidth = size.height * 0.18;
    final linkCount = 4;
    final linkWidth = size.width / (linkCount + 0.5);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = linkColor;

    for (var i = 0; i < linkCount; i++) {
      final rect = Rect.fromLTWH(
        strokeWidth / 2 + (linkWidth * 0.85) * i,
        size.height * (i.isOdd ? 0.2 : 0),
        linkWidth,
        size.height * 0.75,
      );
      final rRect = RRect.fromRectAndRadius(rect, Radius.circular(linkWidth));
      final pivot = Offset(rect.left + rect.width / 2, rect.top + rect.height / 2);
      canvas.save();
      canvas.translate(pivot.dx, pivot.dy);
      canvas.rotate(i.isOdd ? -0.12 : 0.12);
      canvas.translate(-pivot.dx, -pivot.dy);
      canvas.drawRRect(rRect, paint);
      canvas.restore();
    }

    final highlightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.45
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF6FE7A3).withOpacity(0.6);

    for (var i = 0; i < linkCount; i++) {
      final rect = Rect.fromLTWH(
        strokeWidth / 2 + (linkWidth * 0.85) * i,
        size.height * (i.isOdd ? 0.2 : 0),
        linkWidth,
        size.height * 0.75,
      );
      final rRect = RRect.fromRectAndRadius(rect, Radius.circular(linkWidth));
      final pivot = Offset(rect.left + rect.width / 2, rect.top + rect.height / 2);
      canvas.save();
      canvas.translate(pivot.dx, pivot.dy);
      canvas.rotate(i.isOdd ? -0.12 : 0.12);
      canvas.translate(-pivot.dx, -pivot.dy);
      canvas.drawRRect(rRect, highlightPaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FemaleAthlete extends StatelessWidget {
  const _FemaleAthlete({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final width = height * 0.68;
    const hairColor = Color(0xFF1F2A44);
    const skinColor = Color(0xFFFFD7C2);
    const topColor = Color(0xFF1EBA68);
    const leggingsColor = Color(0xFF141F33);
    const shoeColor = Color(0xFF0E1727);

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: height * 0.02,
            left: width * 0.08,
            right: width * 0.08,
            child: Container(
              height: height * 0.08,
              decoration: const BoxDecoration(
                color: Color(0x1A000000),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
          ),
          Positioned(
            top: height * 0.02,
            left: width * 0.38,
            child: Container(
              height: height * 0.16,
              width: height * 0.16,
              decoration: const BoxDecoration(
                color: hairColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: height * 0.07,
            left: width * 0.34,
            child: Container(
              height: height * 0.15,
              width: height * 0.15,
              decoration: const BoxDecoration(
                color: skinColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: height * 0.14,
            left: width * 0.33,
            child: Container(
              height: height * 0.12,
              width: width * 0.34,
              decoration: BoxDecoration(
                color: topColor,
                borderRadius: BorderRadius.circular(height * 0.08),
              ),
            ),
          ),
          Positioned(
            top: height * 0.24,
            left: width * 0.28,
            child: Container(
              height: height * 0.16,
              width: width * 0.44,
              decoration: BoxDecoration(
                color: topColor,
                borderRadius: BorderRadius.circular(height * 0.08),
              ),
            ),
          ),
          Positioned(
            top: height * 0.36,
            left: width * 0.32,
            child: Container(
              height: height * 0.22,
              width: width * 0.34,
              decoration: BoxDecoration(
                color: leggingsColor,
                borderRadius: BorderRadius.circular(height * 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.08,
            left: width * 0.22,
            child: Transform.rotate(
              angle: -0.35,
              child: Container(
                height: height * 0.28,
                width: width * 0.16,
                decoration: BoxDecoration(
                  color: leggingsColor,
                  borderRadius: BorderRadius.circular(height * 0.08),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.06,
            right: width * 0.18,
            child: Transform.rotate(
              angle: 0.28,
              child: Container(
                height: height * 0.28,
                width: width * 0.16,
                decoration: BoxDecoration(
                  color: leggingsColor,
                  borderRadius: BorderRadius.circular(height * 0.08),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: width * 0.18,
            child: Container(
              height: height * 0.08,
              width: width * 0.22,
              decoration: BoxDecoration(
                color: shoeColor,
                borderRadius: BorderRadius.circular(height * 0.04),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.01,
            right: width * 0.18,
            child: Container(
              height: height * 0.08,
              width: width * 0.22,
              decoration: BoxDecoration(
                color: shoeColor,
                borderRadius: BorderRadius.circular(height * 0.04),
              ),
            ),
          ),
          Positioned(
            top: height * 0.22,
            left: width * 0.16,
            child: Transform.rotate(
              angle: -0.6,
              child: Container(
                height: height * 0.2,
                width: width * 0.14,
                decoration: BoxDecoration(
                  color: skinColor,
                  borderRadius: BorderRadius.circular(height * 0.08),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.24,
            right: width * 0.04,
            child: Transform.rotate(
              angle: 0.45,
              child: Container(
                height: height * 0.28,
                width: width * 0.16,
                decoration: BoxDecoration(
                  color: skinColor,
                  borderRadius: BorderRadius.circular(height * 0.08),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.18,
            left: width * 0.28,
            right: width * 0.18,
            child: Container(
              height: height * 0.08,
              decoration: BoxDecoration(
                color: topColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(height * 0.08),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaleAthlete extends StatelessWidget {
  const _MaleAthlete({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    final height = width * 0.55;
    const hairColor = Color(0xFF141F33);
    const skinColor = Color(0xFFFFD7C2);
    const shortColor = Color(0xFFE8563A);
    const shoeColor = Color(0xFF0E1727);

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: width * 0.1,
            right: width * 0.1,
            child: Container(
              height: height * 0.12,
              decoration: const BoxDecoration(
                color: Color(0x1A000000),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
          Positioned(
            top: height * 0.05,
            left: width * 0.62,
            child: Container(
              height: height * 0.22,
              width: height * 0.22,
              decoration: const BoxDecoration(
                color: skinColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: height * 0.02,
            left: width * 0.64,
            child: Container(
              height: height * 0.2,
              width: height * 0.2,
              decoration: const BoxDecoration(
                color: hairColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.28,
            left: width * 0.4,
            child: Container(
              height: height * 0.2,
              width: width * 0.26,
              decoration: BoxDecoration(
                color: skinColor,
                borderRadius: BorderRadius.circular(height * 0.1),
              ),
            ),
          ),
          Positioned(
            top: height * 0.35,
            left: width * 0.2,
            child: Container(
              height: height * 0.18,
              width: width * 0.32,
              decoration: BoxDecoration(
                color: shortColor,
                borderRadius: BorderRadius.circular(height * 0.1),
              ),
            ),
          ),
          Positioned(
            top: height * 0.28,
            left: width * 0.1,
            child: Transform.rotate(
              angle: -0.2,
              alignment: Alignment.centerLeft,
              child: Container(
                height: height * 0.2,
                width: width * 0.36,
                decoration: BoxDecoration(
                  color: skinColor,
                  borderRadius: BorderRadius.circular(height * 0.1),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.1,
            right: width * 0.02,
            child: Transform.rotate(
              angle: -0.12,
              child: Container(
                height: height * 0.2,
                width: width * 0.32,
                decoration: BoxDecoration(
                  color: skinColor,
                  borderRadius: BorderRadius.circular(height * 0.1),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: width * 0.18,
            child: Container(
              height: height * 0.12,
              width: width * 0.22,
              decoration: BoxDecoration(
                color: shoeColor,
                borderRadius: BorderRadius.circular(height * 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.02,
            left: width * 0.04,
            child: Container(
              height: height * 0.12,
              width: width * 0.22,
              decoration: BoxDecoration(
                color: shoeColor,
                borderRadius: BorderRadius.circular(height * 0.06),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dumbbell extends StatelessWidget {
  const _Dumbbell();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1EBA68).withOpacity(0.15),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF1EBA68),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Container(
              width: 52,
              height: 12,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF102C1E),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              width: 28,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF1EBA68),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ],
        ),
      ],
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
