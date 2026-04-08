import 'package:flutter/material.dart';

/// Slide 07 — Arquitetura Interna — Visão Geral (3 sub-steps)
class Slide07 extends StatelessWidget {
  final int step;
  const Slide07({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Arquitetura Interna — Visão Geral',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Step 1: CPU + Memória
                      _RevealBlock(
                        visible: step >= 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: _ArchBlock(
                                'Xtensa LX7\nCPU Core 0',
                                const Color(0xFF58A6FF),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _ArchBlock(
                                'Xtensa LX7\nCPU Core 1',
                                const Color(0xFF58A6FF),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _ArchBlock(
                                'SRAM 512KB',
                                const Color(0xFFD2A8FF),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _ArchBlock(
                                'Flash SPI (ext)',
                                const Color(0xFFD2A8FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Barramento + GDMA
                      _RevealBlock(
                        visible: step >= 1,
                        child: _ArchBlock(
                          'System Bus (AHB/AXI)',
                          const Color(0xFFFFA657),
                          wide: true,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _RevealBlock(
                        visible: step >= 2,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF0D2818,
                            ).withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(
                                0xFF3FB950,
                              ).withValues(alpha: 0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'GDMA Controller',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF3FB950),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '5 Canais TX + 5 Canais RX · Prioridade configurável',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color(
                                    0xFF3FB950,
                                  ).withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Step 3: Periféricos
                      _RevealBlock(
                        visible: step >= 3,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _ArchBlock(
                                    'ADC (SAR)\n2x 12-bit',
                                    const Color(0xFFF78166),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _ArchBlock(
                                    'SPI (x4)\nMaster/Slave',
                                    const Color(0xFFF78166),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _ArchBlock(
                                    'I2S (x2)\nÁudio Digital',
                                    const Color(0xFFF78166),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _ArchBlock(
                                    'UART (x3)\nSerial',
                                    const Color(0xFFF78166),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _ArchBlock(
                                    'Wi-Fi 802.11\nb/g/n + BLE 5.0',
                                    const Color(0xFF79C0FF),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _ArchBlock(
                                    'USB OTG 1.1',
                                    const Color(0xFF79C0FF),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _ArchBlock(
                                    'GPIO\n(45 pinos)',
                                    const Color(0xFF79C0FF),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Legenda
                      _RevealBlock(
                        visible: step >= 3,
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 6,
                          children: [
                            _LegendDot('CPU', const Color(0xFF58A6FF)),
                            _LegendDot('Memória', const Color(0xFFD2A8FF)),
                            _LegendDot('Barramento', const Color(0xFFFFA657)),
                            _LegendDot('DMA', const Color(0xFF3FB950)),
                            _LegendDot('Periféricos', const Color(0xFFF78166)),
                            _LegendDot(
                              'Conectividade',
                              const Color(0xFF79C0FF),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchBlock extends StatelessWidget {
  final String label;
  final Color color;
  final bool wide;
  const _ArchBlock(this.label, this.color, {this.wide = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide ? double.infinity : null,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendDot(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 11, color: color)),
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
