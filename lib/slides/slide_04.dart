import 'package:flutter/material.dart';

/// Slide 04 — CPU-Driven vs DMA (Comparação Visual) (2 sub-steps)
class Slide04 extends StatelessWidget {
  final int step;
  const Slide04({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CPU-Driven vs DMA — Comparação Visual',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: Row(
              children: [
                // Lado esquerdo: CPU-Driven
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 1,
                    child: _buildSide(
                      icon: Icons.close_rounded,
                      iconColor: const Color(0xFFF78166),
                      title: 'Acesso Tradicional (CPU-Driven)',
                      bgColor: const Color(0xFF3D1F00),
                      borderColor: const Color(0xFFF78166),
                      blocks: [
                        _FlowBlock(
                          'Periférico (ADC/SPI)',
                          const Color(0xFFF78166),
                          const Color(0xFF21262D),
                        ),
                        _FlowBlock(
                          'CPU (Ocupada!)',
                          const Color(0xFFF78166),
                          const Color(0xFF3D1F00),
                        ),
                        _FlowBlock(
                          'Memória (RAM)',
                          const Color(0xFFF78166),
                          const Color(0xFF21262D),
                        ),
                      ],
                      arrowColor: const Color(0xFFF78166),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // Lado direito: DMA
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 2,
                    child: _buildSide(
                      icon: Icons.check_rounded,
                      iconColor: const Color(0xFF3FB950),
                      title: 'Acesso com DMA',
                      bgColor: const Color(0xFF0D2818),
                      borderColor: const Color(0xFF3FB950),
                      blocks: [
                        _FlowBlock(
                          'Periférico',
                          const Color(0xFF3FB950),
                          const Color(0xFF0D2818),
                        ),
                        _FlowBlock(
                          'DMA Controller',
                          const Color(0xFF3FB950),
                          const Color(0xFF0D2818),
                        ),
                        _FlowBlock(
                          'Memória',
                          const Color(0xFF3FB950),
                          const Color(0xFF0D2818),
                        ),
                        _FlowBlock(
                          'CPU Livre! Outras tarefas',
                          const Color(0xFF3FB950),
                          const Color(0xFF0D2818),
                          dashed: true,
                        ),
                      ],
                      arrowColor: const Color(0xFF3FB950),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Com DMA, a CPU fica livre para executar código enquanto os dados são transferidos automaticamente pelo hardware',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Color(0xFF8B949E)),
          ),
        ],
      ),
    );
  }

  Widget _buildSide({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Color bgColor,
    required Color borderColor,
    required List<_FlowBlock> blocks,
    required Color arrowColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: iconColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(blocks.length * 2 - 1, (i) {
            if (i.isOdd) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: arrowColor,
                  size: 20,
                ),
              );
            }
            final b = blocks[i ~/ 2];
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: b.bg.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: b.color.withValues(alpha: 0.5),
                  style: b.dashed ? BorderStyle.none : BorderStyle.solid,
                ),
              ),
              child: Text(
                b.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: b.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _FlowBlock {
  final String label;
  final Color color;
  final Color bg;
  final bool dashed;
  const _FlowBlock(this.label, this.color, this.bg, {this.dashed = false});
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
