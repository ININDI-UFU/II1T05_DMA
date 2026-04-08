import 'package:flutter/material.dart';

/// Slide 18 — ADC + DMA na ESP32-S3 (3 sub-steps)
class Slide18 extends StatelessWidget {
  final int step;
  const Slide18({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ADC + DMA na ESP32-S3',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 20),
          // ── Card 1: Especificações Técnicas — largura total ──
          _RevealBlock(
            visible: step >= 1,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFD2A8FF).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD2A8FF).withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Especificações Técnicas (ESP32-S3)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFD2A8FF),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    '▸ 2x ADC SAR, 12-bit, até 20 canais',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFFC9D1D9),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFFC9D1D9),
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(text: '▸ Taxa máxima com DMA: '),
                        TextSpan(
                          text: '~83.3 kHz por canal',
                          style: TextStyle(
                            color: Color(0xFF3FB950),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3FB950).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF3FB950).withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Text(
                      'Com DMA, a CPU fica 100% livre durante a aquisição contínua de dados analógicos.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF3FB950),
                        fontStyle: FontStyle.italic,
                        height: 1.5,
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
                        color: const Color(0xFFF78166).withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFF78166).withValues(alpha: 0.25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Leitura Simples (oneshot)',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF78166),
                            ),
                          ),
                          SizedBox(height: 14),
                          Text(
                            '▸ CPU solicita → ADC converte → CPU lê resultado',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFFC9D1D9),
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '▸ Bloqueante: CPU espera ~25 µs',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFFC9D1D9),
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '▸ Máximo prático: ~40 kSPS',
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
                const SizedBox(width: 24),
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 3,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
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
                        children: const [
                          Text(
                            'Leitura Contínua com DMA',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3FB950),
                            ),
                          ),
                          SizedBox(height: 14),
                          Text(
                            '▸ ADC opera em modo contínuo (free-running)',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFFC9D1D9),
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '▸ DMA transfere automaticamente para buffer na RAM',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFFC9D1D9),
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '▸ Interrupção ao preencher metade do buffer',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFFC9D1D9),
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '▸ CPU processa enquanto DMA preenche outra metade',
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
                ),
              ],
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
