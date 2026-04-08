import 'package:flutter/material.dart';

/// Slide 22 — Seção 07: Código Prático
class Slide22 extends StatelessWidget {
  const Slide22({super.key});

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
                TextSpan(text: '07', style: TextStyle(color: Color(0xFFF78166))),
                TextSpan(text: ' — Código Prático', style: TextStyle(color: Color(0xFFF0F0F0))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Implementação com adc_continuous no ESP-IDF',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Color(0xFF8B949E)),
          ),
        ],
      ),
    );
  }
}
