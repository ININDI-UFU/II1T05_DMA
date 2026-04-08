import 'package:flutter/material.dart';

/// Slide 17 — Seção 05: DMA + Leitura Analógica
class Slide17 extends StatelessWidget {
  const Slide17({super.key});

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
                TextSpan(text: '05', style: TextStyle(color: Color(0xFF58A6FF))),
                TextSpan(text: ' — DMA + Leitura Analógica', style: TextStyle(color: Color(0xFFF0F0F0))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'ADC contínuo, buffer circular e alta frequência',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Color(0xFF8B949E)),
          ),
        ],
      ),
    );
  }
}
