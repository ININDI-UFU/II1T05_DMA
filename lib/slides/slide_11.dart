import 'package:flutter/material.dart';

/// Slide 11 — Fluxo Convencional (sem DMA) (2 sub-steps)
class Slide11 extends StatelessWidget {
  final int step;
  const Slide11({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fluxo Convencional (sem DMA)',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 24),
          // Timeline diagram
          _RevealBlock(visible: step >= 1, child: _buildTimeline()),
          const SizedBox(height: 20),
          // Callout
          _RevealBlock(
            visible: step >= 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF2D1600).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFF78166).withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                children: [
                  const Text('⚠', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFFC9D1D9),
                        ),
                        children: [
                          TextSpan(
                            text: 'CPU 100% ocupada',
                            style: TextStyle(
                              color: Color(0xFFF78166),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' — Cada byte passa pela CPU. Não há paralelismo. Gargalo em alta frequência.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TimelineRow(
          label: 'CPU',
          labelColor: const Color(0xFFF78166),
          blocks: [
            _TBlock('Lê ADC', const Color(0xFF3D1F00), const Color(0xFFF78166)),
            _TBlock(
              'Move→RAM',
              const Color(0xFF3D1F00),
              const Color(0xFFF78166),
            ),
            _TBlock('Lê ADC', const Color(0xFF3D1F00), const Color(0xFFF78166)),
            _TBlock(
              'Move→RAM',
              const Color(0xFF3D1F00),
              const Color(0xFFF78166),
            ),
            _TBlock(
              'Processa',
              const Color(0xFF3D1F00),
              const Color(0xFFF78166),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _TimelineRow(
          label: 'Barramento',
          labelColor: const Color(0xFF8B949E),
          blocks: [
            _TBlock(
              'Ocupado',
              const Color(0xFF21262D),
              const Color(0xFF8B949E),
            ),
            _TBlock(
              'Ocupado',
              const Color(0xFF21262D),
              const Color(0xFF8B949E),
            ),
            _TBlock(
              'Ocupado',
              const Color(0xFF21262D),
              const Color(0xFF8B949E),
            ),
            _TBlock(
              'Ocupado',
              const Color(0xFF21262D),
              const Color(0xFF8B949E),
            ),
            _TBlock(
              'Ocupado',
              const Color(0xFF21262D),
              const Color(0xFF8B949E),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _TimelineRow(
          label: 'Periférico',
          labelColor: const Color(0xFFFFA657),
          blocks: [
            _TBlock('Ativo', const Color(0xFF2D1600), const Color(0xFFFFA657)),
            _TBlock('Idle', const Color(0xFF161B22), const Color(0xFF8B949E)),
            _TBlock('Ativo', const Color(0xFF2D1600), const Color(0xFFFFA657)),
            _TBlock('Idle', const Color(0xFF161B22), const Color(0xFF8B949E)),
            _TBlock('Idle', const Color(0xFF161B22), const Color(0xFF8B949E)),
          ],
        ),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'tempo →',
            style: TextStyle(fontSize: 11, color: Color(0xFF8B949E)),
          ),
        ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final String label;
  final Color labelColor;
  final List<_TBlock> blocks;
  const _TimelineRow({
    required this.label,
    required this.labelColor,
    required this.blocks,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: labelColor,
            ),
          ),
        ),
        ...blocks.expand(
          (b) => [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: b.bg,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: b.textColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  b.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: b.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TBlock {
  final String label;
  final Color bg;
  final Color textColor;
  const _TBlock(this.label, this.bg, this.textColor);
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
