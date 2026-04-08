import 'package:flutter/material.dart';

/// Slide 19 — Buffer Circular — Double Buffering (2 sub-steps)
class Slide19 extends StatelessWidget {
  final int step;
  const Slide19({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Buffer Circular — Double Buffering',
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
                // Lado esquerdo: Diagrama visual
                Expanded(
                  flex: 3,
                  child: _RevealBlock(
                    visible: step >= 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _BufferBox(
                                'BUFFER A',
                                const Color(0xFF3FB950),
                                'DMA escrevendo ↓',
                                ['D0', 'D1', 'D2', '...'],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'SWAP',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFFA657),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Icon(
                                    Icons.swap_horiz_rounded,
                                    color: const Color(0xFFFFA657),
                                    size: 32,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: _BufferBox(
                                'BUFFER B',
                                const Color(0xFF58A6FF),
                                'CPU processando ↓',
                                ['D0', 'D1', 'D2', 'D3', 'D4'],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Lado direito: Explicação
                Expanded(
                  flex: 2,
                  child: _RevealBlock(
                    visible: step >= 2,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161B22).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFFA657).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Como funciona',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFFA657),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...[
                            '1. DMA preenche Buffer A com dados do ADC',
                            '2. Quando A está cheio, IRQ sinaliza',
                            '3. DMA troca para Buffer B (swap)',
                            '4. CPU processa Buffer A enquanto DMA enche B',
                            '5. Ciclo contínuo sem perda de dados',
                          ].map(
                            (s) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                s,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFC9D1D9),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFC9D1D9),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Vantagem: ',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text:
                                      'Zero gap entre aquisição e processamento',
                                  style: TextStyle(
                                    color: Color(0xFF3FB950),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
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
          const SizedBox(height: 10),
          const Text(
            'O padrão ping-pong é implementado automaticamente pelo driver adc_continuous do ESP-IDF',
            style: TextStyle(fontSize: 14, color: Color(0xFF8B949E)),
          ),
        ],
      ),
    );
  }
}

class _BufferBox extends StatelessWidget {
  final String title;
  final Color color;
  final String subtitle;
  final List<String> cells;
  const _BufferBox(this.title, this.color, this.subtitle, this.cells);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: color.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: cells
                .map(
                  (c) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: color.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      c,
                      style: TextStyle(
                        fontSize: 13,
                        color: color,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                )
                .toList(),
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
