import 'package:flutter/material.dart';

/// Slide 15 — 4 Pilares do DMA (4 sub-steps)
class Slide15 extends StatelessWidget {
  final int step;
  const Slide15({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '4 Pilares do DMA',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFFF0F0F0)),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: _RevealBlock(
                          visible: step >= 1,
                          child: _PillarCard(
                            icon: Icons.speed_rounded,
                            title: 'Redução de Carga',
                            color: const Color(0xFF58A6FF),
                            bgColor: const Color(0xFF0D1F33),
                            lines: ['CPU livre para lógica de aplicação', 'De ~90% para ~0% de uso em I/O'],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: _RevealBlock(
                          visible: step >= 3,
                          child: _PillarCard(
                            icon: Icons.timer_rounded,
                            title: 'Determinismo',
                            color: const Color(0xFFD2A8FF),
                            bgColor: const Color(0xFF1A0D2B),
                            lines: ['Timing preciso por hardware', 'Jitter ±0 na aquisição'],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: _RevealBlock(
                          visible: step >= 2,
                          child: _PillarCard(
                            icon: Icons.trending_up_rounded,
                            title: 'Maior Throughput',
                            color: const Color(0xFF3FB950),
                            bgColor: const Color(0xFF0D2818),
                            lines: ['Velocidade máxima do barramento', 'Transferências burst otimizadas'],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: _RevealBlock(
                          visible: step >= 4,
                          child: _PillarCard(
                            icon: Icons.access_time_filled_rounded,
                            title: 'Tempo Real',
                            color: const Color(0xFFF78166),
                            bgColor: const Color(0xFF2D1600),
                            lines: ['Ideal para controle e monitoramento', 'Aquisição contínua garantida'],
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

class _PillarCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Color bgColor;
  final List<String> lines;
  const _PillarCard({required this.icon, required this.title, required this.color, required this.bgColor, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 10),
              Flexible(
                child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...lines.map((l) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(l, style: const TextStyle(fontSize: 13, color: Color(0xFFC9D1D9))),
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
