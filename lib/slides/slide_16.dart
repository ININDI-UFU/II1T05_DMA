import 'package:flutter/material.dart';

/// Slide 16 — Exemplos de Uso do DMA (4 sub-steps)
class Slide16 extends StatelessWidget {
  final int step;
  const Slide16({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Exemplos de Uso do DMA',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFFF0F0F0)),
          ),
          const SizedBox(height: 28),
          _RevealBlock(
            visible: step >= 1,
            child: _ExampleCard(
              title: 'Aquisição Contínua de Sinais',
              color: const Color(0xFF58A6FF),
              bullets: [
                '▸ Sensores de vibração, temperatura, pressão',
                '▸ ADC contínuo a 100 kHz+ sem perda',
              ],
            ),
          ),
          const SizedBox(height: 14),
          _RevealBlock(
            visible: step >= 2,
            child: _ExampleCard(
              title: 'Processamento de Áudio',
              color: const Color(0xFF3FB950),
              bullets: [
                '▸ I2S + DMA para streaming em tempo real',
                '▸ Microfone MEMS → FFT → classificação ML',
              ],
            ),
          ),
          const SizedBox(height: 14),
          _RevealBlock(
            visible: step >= 3,
            child: _ExampleCard(
              title: 'Comunicação de Alta Velocidade',
              color: const Color(0xFFD2A8FF),
              bullets: [
                '▸ SPI Master a 80 MHz com DMA full-duplex',
                '▸ Displays TFT, memória externa, comunicação inter-chip',
              ],
            ),
          ),
          const SizedBox(height: 14),
          _RevealBlock(
            visible: step >= 4,
            child: _ExampleCard(
              title: 'Controle Industrial',
              color: const Color(0xFFF78166),
              bullets: [
                '▸ Malhas de controle PID com aquisição determinística',
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> bullets;
  const _ExampleCard({required this.title, required this.color, required this.bullets});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 6),
          ...bullets.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(b, style: const TextStyle(fontSize: 14, color: Color(0xFFC9D1D9))),
              )),
        ],
      ),
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
