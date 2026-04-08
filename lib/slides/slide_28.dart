import 'package:flutter/material.dart';

/// Slide 28 — Obrigado! (slide final)
class Slide28 extends StatelessWidget {
  const Slide28({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Obrigado!',
            style: TextStyle(fontSize: 52, fontWeight: FontWeight.w700, color: Color(0xFFF0F0F0)),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(fontSize: 22, color: Color(0xFF8B949E)),
              children: [
                TextSpan(text: 'DMA na ESP32-S3 '),
                TextSpan(text: '— ', style: TextStyle(color: Color(0xFF58A6FF))),
                TextSpan(text: 'Acesso Direto à Memória'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF161B22),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF30363D)),
            ),
            child: const Text(
              'Dúvidas?',
              style: TextStyle(fontSize: 17, color: Color(0xFF3FB950), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
