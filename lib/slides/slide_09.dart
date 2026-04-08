import 'package:flutter/material.dart';

/// Slide 09 — Integração DMA + Periféricos (2 sub-steps)
class Slide09 extends StatelessWidget {
  final int step;
  const Slide09({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Integração DMA + Periféricos',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coluna esquerda
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _IntegrationCard(
                          title: 'ADC + DMA',
                          color: const Color(0xFF58A6FF),
                          bullets: [
                            '▸ Modo contínuo com DMA',
                            '▸ Buffer circular automático',
                            '▸ Até 2 MSPS por canal',
                          ],
                        ),
                        const SizedBox(height: 16),
                        _IntegrationCard(
                          title: 'SPI + DMA',
                          color: const Color(0xFF3FB950),
                          bullets: [
                            '▸ Transferências full-duplex',
                            '▸ Até 80 MHz clock',
                            '▸ Ideal para displays e sensores',
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // Coluna direita
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _IntegrationCard(
                          title: 'I2S + DMA',
                          color: const Color(0xFFD2A8FF),
                          bullets: [
                            '▸ Streaming de áudio contínuo',
                            '▸ Buffer double-ping-pong',
                            '▸ Até 96 kHz / 24-bit',
                          ],
                        ),
                        const SizedBox(height: 16),
                        _IntegrationCard(
                          title: 'UART + DMA',
                          color: const Color(0xFFF78166),
                          bullets: [
                            '▸ Recepção sem polling',
                            '▸ Ideal para GPS, Modbus',
                            '▸ Zero overhead na CPU',
                          ],
                        ),
                      ],
                    ),
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

class _IntegrationCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> bullets;
  const _IntegrationCard({
    required this.title,
    required this.color,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                b,
                style: const TextStyle(fontSize: 14, color: Color(0xFFC9D1D9)),
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
