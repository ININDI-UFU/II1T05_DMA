import 'package:flutter/material.dart';

/// Slide 06 — Seção 02: Arquitetura ESP32-S3
class Slide06 extends StatelessWidget {
  const Slide06({super.key});

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
                TextSpan(text: '02', style: TextStyle(color: Color(0xFF3FB950))),
                TextSpan(text: ' — Arquitetura ESP32-S3', style: TextStyle(color: Color(0xFFF0F0F0))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Organização interna, barramentos e controlador DMA',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Color(0xFF8B949E)),
          ),
        ],
      ),
    );
  }
}
