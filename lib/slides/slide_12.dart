import 'package:flutter/material.dart';

/// Slide 12 — Fluxo com DMA — Execução Paralela (2 sub-steps)
class Slide12 extends StatelessWidget {
  final int step;
  const Slide12({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fluxo com DMA — Execução Paralela',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 24),
          _RevealBlock(visible: step >= 1, child: _buildTimeline()),
          const SizedBox(height: 20),
          _RevealBlock(
            visible: step >= 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF0D2818).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF3FB950).withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                children: [
                  const Text('✅', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFC9D1D9),
                        ),
                        children: [
                          TextSpan(
                            text: 'CPU livre para processar',
                            style: TextStyle(
                              color: Color(0xFF3FB950),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' — DMA move dados em paralelo. Aquisição contínua sem perda de amostras.',
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
          labelColor: const Color(0xFF3FB950),
          blocks: [
            _TBlock(
              'Processa dados',
              const Color(0xFF0D2818),
              const Color(0xFF3FB950),
              flex: 2,
            ),
            _TBlock(
              'Algoritmo PID',
              const Color(0xFF0D2818),
              const Color(0xFF3FB950),
              flex: 2,
            ),
            _TBlock(
              'WiFi',
              const Color(0xFF0D2818),
              const Color(0xFF3FB950),
              flex: 1,
            ),
          ],
        ),
        const SizedBox(height: 10),
        _TimelineRow(
          label: 'DMA',
          labelColor: const Color(0xFF58A6FF),
          blocks: [
            _TBlock(
              'ADC→RAM',
              const Color(0xFF0D1F33),
              const Color(0xFF58A6FF),
              flex: 1,
            ),
            _TBlock(
              'ADC→RAM',
              const Color(0xFF0D1F33),
              const Color(0xFF58A6FF),
              flex: 1,
            ),
            _TBlock(
              'ADC→RAM',
              const Color(0xFF0D1F33),
              const Color(0xFF58A6FF),
              flex: 1,
            ),
            _TBlock(
              'ADC→RAM',
              const Color(0xFF0D1F33),
              const Color(0xFF58A6FF),
              flex: 1,
            ),
            _TBlock(
              'ADC→RAM',
              const Color(0xFF0D1F33),
              const Color(0xFF58A6FF),
              flex: 1,
            ),
          ],
        ),
        const SizedBox(height: 10),
        _TimelineRow(
          label: 'Periférico',
          labelColor: const Color(0xFF3FB950),
          blocks: [
            _TBlock(
              'Aquisição contínua (sem interrupção da CPU)',
              const Color(0xFF0D2818),
              const Color(0xFF3FB950),
              flex: 5,
            ),
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
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: labelColor,
            ),
          ),
        ),
        ...blocks.map(
          (b) => Expanded(
            flex: b.flex,
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
                  fontSize: 10,
                  color: b.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TBlock {
  final String label;
  final Color bg;
  final Color textColor;
  final int flex;
  const _TBlock(this.label, this.bg, this.textColor, {this.flex = 1});
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
