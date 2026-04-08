import 'package:flutter/material.dart';

/// Slide 02 — Seção 01: Fundamentos de DMA
class Slide02 extends StatelessWidget {
  const Slide02({super.key});

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
                TextSpan(text: '01', style: TextStyle(color: Color(0xFF58A6FF))),
                TextSpan(text: ' — Fundamentos de DMA', style: TextStyle(color: Color(0xFFF0F0F0))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'O que é Direct Memory Access e por que é essencial',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Color(0xFF8B949E)),
          ),
        ],
      ),
    );
  }
}
