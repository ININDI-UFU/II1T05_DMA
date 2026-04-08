import 'package:flutter/material.dart';

/// Slide 08 — Controlador GDMA — Detalhes (3 sub-steps)
class Slide08 extends StatelessWidget {
  final int step;
  const Slide08({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Controlador GDMA — Detalhes',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 20),
          // ── Card 1: GDMA — largura total ──
          _RevealBlock(
            visible: step >= 1,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF3FB950).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF3FB950).withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'General DMA (GDMA)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3FB950),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...[
                    '▸ 5 canais de transmissão (TX) + 5 canais de recepção (RX)',
                    '▸ Linked-list descriptors para transferências encadeadas',
                    '▸ Suporte a burst transfers (4-byte aligned)',
                    '▸ Prioridade configurável por canal',
                  ].map(
                    (b) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
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
            ),
          ),
          const SizedBox(height: 16),
          // ── Cards 2 e 3: lado a lado ──
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 2,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF58A6FF).withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(
                            0xFF58A6FF,
                          ).withValues(alpha: 0.25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Modos de Transferência',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF58A6FF),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _TransferMode(
                            'Periférico → Memória',
                            const Color(0xFF3FB950),
                            'leitura ADC, recepção SPI',
                          ),
                          const SizedBox(height: 10),
                          _TransferMode(
                            'Memória → Periférico',
                            const Color(0xFF58A6FF),
                            'transmissão SPI, saída I2S',
                          ),
                          const SizedBox(height: 10),
                          _TransferMode(
                            'Memória → Memória',
                            const Color(0xFFD2A8FF),
                            'cópia rápida de blocos',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 3,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF78166).withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(
                            0xFFF78166,
                          ).withValues(alpha: 0.25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Interrupções GDMA',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF78166),
                            ),
                          ),
                          SizedBox(height: 14),
                          Text(
                            '▸ Transfer complete, Half-transfer, Error',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFFC9D1D9),
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '▸ Permite processamento em double-buffer (ping-pong)',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFFC9D1D9),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
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

class _TransferMode extends StatelessWidget {
  final String label;
  final Color color;
  final String desc;
  const _TransferMode(this.label, this.color, this.desc);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '($desc)',
            style: const TextStyle(fontSize: 15, color: Color(0xFF8B949E)),
          ),
        ),
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
