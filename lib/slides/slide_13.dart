import 'package:flutter/material.dart';

/// Slide 13 — Gargalos e Latência — Análise Técnica (3 sub-steps)
class Slide13 extends StatelessWidget {
  final int step;
  const Slide13({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gargalos e Latência — Análise Técnica',
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
                // Sem DMA
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 1,
                    child: _MetricsCard(
                      title: 'Sem DMA — Gargalos',
                      titleColor: const Color(0xFFF78166),
                      bgColor: const Color(0xFF2D1600),
                      items: [
                        _Metric(
                          'Cada leitura ADC:',
                          '~20-50 ciclos',
                          const Color(0xFFF78166),
                        ),
                        _Metric(
                          'A 1 MSPS =',
                          '20-50M ciclos/s só para I/O',
                          const Color(0xFFF78166),
                        ),
                        _Metric(
                          'CPU @ 240 MHz →',
                          '~20% gasto só em transferência',
                          const Color(0xFFF78166),
                        ),
                        _Metric(
                          'Jitter de interrupção:',
                          '±1-5 µs',
                          const Color(0xFFF78166),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // Com DMA
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 2,
                    child: _MetricsCard(
                      title: 'Com DMA — Desempenho',
                      titleColor: const Color(0xFF3FB950),
                      bgColor: const Color(0xFF0D2818),
                      items: [
                        _Metric(
                          'CPU overhead:',
                          '~0%',
                          const Color(0xFF3FB950),
                        ),
                        _Metric(
                          'Throughput:',
                          'máximo do barramento',
                          const Color(0xFF3FB950),
                        ),
                        _Metric(
                          'Jitter de aquisição:',
                          '±0 (hardware-timed)',
                          const Color(0xFF3FB950),
                        ),
                        _Metric(
                          'Buffer circular:',
                          'elimina perda de dados',
                          const Color(0xFF3FB950),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Resumo comparativo
          _RevealBlock(
            visible: step >= 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF161B22),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF58A6FF).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CompareItem('CPU Load', '~90%', '~0%'),
                  _CompareItem('Jitter', '±5µs', '±0'),
                  _CompareItem('Amostras', 'Perdas', 'Zero perda'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsCard extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Color bgColor;
  final List<_Metric> items;
  const _MetricsCard({
    required this.title,
    required this.titleColor,
    required this.bgColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: titleColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (m) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color(0xFFC9D1D9),
                  ),
                  children: [
                    TextSpan(text: '▸ ${m.label} '),
                    TextSpan(
                      text: m.value,
                      style: TextStyle(
                        color: m.color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric {
  final String label;
  final String value;
  final Color color;
  const _Metric(this.label, this.value, this.color);
}

class _CompareItem extends StatelessWidget {
  final String label;
  final String bad;
  final String good;
  const _CompareItem(this.label, this.bad, this.good);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, color: Color(0xFF8B949E)),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              bad,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFF78166),
                fontWeight: FontWeight.w700,
              ),
            ),
            const Text(
              ' → ',
              style: TextStyle(fontSize: 16, color: Color(0xFF8B949E)),
            ),
            Text(
              good,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF3FB950),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
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
