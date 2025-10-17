import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5FBFF), Color(0xFFEAF5FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/giris.png',
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                ),
                Align(
                  alignment: const Alignment(0, 0.78),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/setup/step1');
                    },
                    child: const SizedBox(width: 320, height: 56),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
