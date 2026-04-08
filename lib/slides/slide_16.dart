import 'package:flutter/material.dart';

/// Slide 16 — Exemplos de Uso do DMA (4 sub-steps)
class Slide16 extends StatelessWidget {
  final int step;
  const Slide16({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Exemplos de Uso do DMA',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Coluna esquerda ──
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: _RevealBlock(
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
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _RevealBlock(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // ── Coluna direita ──
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: _RevealBlock(
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
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _RevealBlock(
                          visible: step >= 4,
                          child: _ExampleCard(
                            title: 'Controle Industrial',
                            color: const Color(0xFFF78166),
                            bullets: [
                              '▸ Malhas de controle PID com aquisição determinística',
                              '▸ Monitoramento contínuo sem perda de dados',
                            ],
                          ),
                        ),
                      ),
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
}

class _ExampleCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> bullets;
  const _ExampleCard({
    required this.title,
    required this.color,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                b,
                style: const TextStyle(
                  fontSize: 17,
                  color: Color(0xFFC9D1D9),
                  height: 1.4,
                ),
              ),
            ),
          ),
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
