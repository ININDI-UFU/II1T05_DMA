import 'package:flutter/material.dart';

/// Slide 10 — Seção 03: Fluxo de Dados
class Slide10 extends StatelessWidget {
  const Slide10({super.key});

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
                TextSpan(text: '03', style: TextStyle(color: Color(0xFFF78166))),
                TextSpan(text: ' — Fluxo de Dados', style: TextStyle(color: Color(0xFFF0F0F0))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Convencional vs DMA — Linha do tempo de execução',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Color(0xFF8B949E)),
          ),
        ],
      ),
    );
  }
}
