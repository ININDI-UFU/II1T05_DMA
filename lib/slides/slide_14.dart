import 'package:flutter/material.dart';

/// Slide 14 — Seção 04: Vantagens do DMA
class Slide14 extends StatelessWidget {
  const Slide14({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700),
              children: [
                TextSpan(text: '04', style: TextStyle(color: Color(0xFFD2A8FF))),
                TextSpan(text: ' — Vantagens do DMA', style: TextStyle(color: Color(0xFFF0F0F0))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Performance, determinismo e aplicações em tempo real',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Color(0xFF8B949E)),
          ),
        ],
      ),
    );
  }
}
