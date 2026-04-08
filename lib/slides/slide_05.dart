import 'package:flutter/material.dart';

/// Slide 05 — Por que DMA é Essencial? (3 sub-steps)
class Slide05 extends StatelessWidget {
  final int step;
  const Slide05({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Por que DMA é Essencial?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 20),
          // ── Card 1: largura total ──
          _RevealBlock(
            visible: step >= 1,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF58A6FF).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF58A6FF).withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Sistemas Embarcados Modernos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF58A6FF),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...[
                    '▸ Múltiplos periféricos operando simultaneamente',
                    '▸ Taxas de aquisição de dados cada vez maiores',
                    '▸ Requisitos de tempo real com latências críticas',
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
                        color: const Color(0xFF2D1600).withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFF78166).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sem DMA — Problemas',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF78166),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _hlText(
                            '▸ CPU gasta ciclos movendo bytes (até ',
                            '70–90%',
                            ')',
                            const Color(0xFFF78166),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '▸ Perda de amostras em alta frequência',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFFC9D1D9),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '▸ Jitter temporal inaceitável para controle PID',
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
                        color: const Color(0xFF0D2818).withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF3FB950).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Com DMA — Solução',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3FB950),
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            '▸ Transferências automáticas em background',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFFC9D1D9),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _hlText(
                            '▸ Zero perda de amostras com ',
                            'buffer circular',
                            null,
                            const Color(0xFF3FB950),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '▸ Determinismo temporal para aplicações críticas',
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

  static Widget _hlText(
    String prefix,
    String highlight,
    String? suffix,
    Color color,
  ) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 17,
          color: Color(0xFFC9D1D9),
          height: 1.4,
        ),
        children: [
          TextSpan(text: prefix),
          TextSpan(
            text: highlight,
            style: TextStyle(color: color, fontWeight: FontWeight.w700),
          ),
          if (suffix != null) TextSpan(text: suffix),
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
