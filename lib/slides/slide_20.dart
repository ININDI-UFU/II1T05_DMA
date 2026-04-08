import 'package:flutter/material.dart';

/// Slide 20 — Seção 06: Configuração PlatformIO
class Slide20 extends StatelessWidget {
  const Slide20({super.key});

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
                TextSpan(text: '06', style: TextStyle(color: Color(0xFF3FB950))),
                TextSpan(text: ' — Configuração PlatformIO', style: TextStyle(color: Color(0xFFF0F0F0))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Ambiente, framework e configuração do projeto',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Color(0xFF8B949E)),
          ),
        ],
      ),
    );
  }
}
