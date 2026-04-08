import 'package:flutter/material.dart';

/// Slide 08 — Controlador GDMA — Detalhes (3 sub-steps)
class Slide08 extends StatelessWidget {
  final int step;
  const Slide08({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Controlador GDMA — Detalhes',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFFF0F0F0)),
          ),
          const SizedBox(height: 28),
          _RevealBlock(
            visible: step >= 1,
            child: _buildBulletSection(
              'General DMA (GDMA)',
              const Color(0xFF3FB950),
              [
                '▸ 5 canais de transmissão (TX) + 5 canais de recepção (RX)',
                '▸ Linked-list descriptors para transferências encadeadas',
                '▸ Suporte a burst transfers (4-byte aligned)',
                '▸ Prioridade configurável por canal',
              ],
            ),
          ),
          const SizedBox(height: 20),
          _RevealBlock(
            visible: step >= 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Modos de Transferência',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF58A6FF)),
                ),
                const SizedBox(height: 8),
                _TransferMode('Periférico → Memória', const Color(0xFF3FB950), 'leitura ADC, recepção SPI'),
                const SizedBox(height: 6),
                _TransferMode('Memória → Periférico', const Color(0xFF58A6FF), 'transmissão SPI, saída I2S'),
                const SizedBox(height: 6),
                _TransferMode('Memória → Memória', const Color(0xFFD2A8FF), 'cópia rápida de blocos'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _RevealBlock(
            visible: step >= 3,
            child: _buildBulletSection(
              'Interrupções GDMA',
              const Color(0xFFF78166),
              [
                '▸ Transfer complete, Half-transfer, Error',
                '▸ Permite processamento em double-buffer (ping-pong)',
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletSection(String title, Color titleColor, List<String> bullets) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: titleColor)),
        const SizedBox(height: 8),
        ...bullets.map((b) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(b, style: const TextStyle(fontSize: 14, color: Color(0xFFC9D1D9))),
            )),
      ],
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        ),
        const SizedBox(width: 10),
        Text('($desc)', style: const TextStyle(fontSize: 13, color: Color(0xFF8B949E))),
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
