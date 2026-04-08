import 'package:flutter/material.dart';

/// Slide 18 — ADC + DMA na ESP32-S3 (3 sub-steps)
class Slide18 extends StatelessWidget {
  final int step;
  const Slide18({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ADC + DMA na ESP32-S3',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFFF0F0F0)),
          ),
          const SizedBox(height: 28),
          _RevealBlock(
            visible: step >= 1,
            child: _buildBulletSection(
              'Leitura Simples (oneshot)',
              const Color(0xFFF78166),
              [
                '▸ CPU solicita → ADC converte → CPU lê resultado',
                '▸ Bloqueante: CPU espera ~25 µs',
                '▸ Máximo prático: ~40 kSPS',
              ],
            ),
          ),
          const SizedBox(height: 20),
          _RevealBlock(
            visible: step >= 2,
            child: _buildBulletSection(
              'Leitura Contínua com DMA',
              const Color(0xFF3FB950),
              [
                '▸ ADC opera em modo contínuo (free-running)',
                '▸ DMA transfere automaticamente para buffer na RAM',
                '▸ Interrupção ao preencher metade do buffer (half-transfer)',
                '▸ CPU processa enquanto DMA preenche outra metade',
              ],
            ),
          ),
          const SizedBox(height: 20),
          _RevealBlock(
            visible: step >= 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Especificações Técnicas (ESP32-S3)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFD2A8FF)),
                ),
                const SizedBox(height: 8),
                const Text('▸ 2x ADC SAR, 12-bit, até 20 canais', style: TextStyle(fontSize: 14, color: Color(0xFFC9D1D9))),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 14, color: Color(0xFFC9D1D9)),
                    children: [
                      TextSpan(text: '▸ Taxa máxima com DMA: '),
                      TextSpan(text: '~83.3 kHz por canal', style: TextStyle(color: Color(0xFF3FB950), fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletSection(String title, Color titleColor, List<String> bullets) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: titleColor)),
        const SizedBox(height: 8),
        ...bullets.map((b) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(b, style: const TextStyle(fontSize: 14, color: Color(0xFFC9D1D9))),
            )),
      ],
    );
  }
}

class _RevealBlock extends StatelessWidget {
  final bool visible;
  final Widget child;
  const _RevealBlock({required this.visible, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 450),
      child: AnimatedScale(
        scale: visible ? 1.0 : 0.92,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
        child: IgnorePointer(ignoring: !visible, child: child),
      ),
    );
  }
}
