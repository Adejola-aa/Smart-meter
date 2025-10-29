import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF003A9B), Color(0xFF00A5FF)],
          ),
        ),
      ),
    );
  }
}

class GradientForm extends StatelessWidget {
  const GradientForm({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.85;
    return Center(
      child: SizedBox(
        width: cardWidth,
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 36, 22, 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0A63FF), Color(0xFF006CE6)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 22,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: Colors.blueAccent.withValues(alpha: 0.14),
                blurRadius: 30,
                spreadRadius: 2,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
