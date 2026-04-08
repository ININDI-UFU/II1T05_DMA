import 'package:flutter/material.dart';

/// Slide 05 — Por que DMA é Essencial? (3 sub-steps)
class Slide05 extends StatelessWidget {
  final int step;
  const Slide05({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Por que DMA é Essencial?',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xFFF0F0F0)),
          ),
          const SizedBox(height: 28),
          _RevealBlock(
            visible: step >= 1,
            child: _buildBulletSection(
              'Sistemas Embarcados Modernos',
              const Color(0xFF58A6FF),
              [
                '▸ Múltiplos periféricos operando simultaneamente',
                '▸ Taxas de aquisição de dados cada vez maiores',
                '▸ Requisitos de tempo real com latências críticas',
              ],
            ),
          ),
          const SizedBox(height: 20),
          _RevealBlock(
            visible: step >= 2,
            child: _buildHighlightSection(
              'Sem DMA — Problemas',
              const Color(0xFF3FB950),
              [
                _HL('▸ CPU gasta ciclos movendo bytes (até ', '70–90%', ')', const Color(0xFFF78166)),
                _HL('▸ Perda de amostras em alta frequência', null, null, null),
                _HL('▸ Jitter temporal inaceitável para controle PID', null, null, null),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _RevealBlock(
            visible: step >= 3,
            child: _buildHighlightSection(
              'Com DMA — Solução',
              const Color(0xFFD2A8FF),
              [
                _HL('▸ Transferências automáticas em background', null, null, null),
                _HL('▸ Zero perda de amostras com ', 'buffer circular', null, const Color(0xFF3FB950)),
                _HL('▸ Determinismo temporal para aplicações críticas', null, null, null),
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

  Widget _buildHighlightSection(String title, Color titleColor, List<_HL> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: titleColor)),
        const SizedBox(height: 8),
        ...items.map((item) {
          if (item.highlight == null) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(item.prefix, style: const TextStyle(fontSize: 14, color: Color(0xFFC9D1D9))),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Color(0xFFC9D1D9)),
                children: [
                  TextSpan(text: item.prefix),
                  TextSpan(text: item.highlight, style: TextStyle(color: item.highlightColor, fontWeight: FontWeight.w700)),
                  if (item.suffix != null) TextSpan(text: item.suffix),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _HL {
  final String prefix;
  final String? highlight;
  final String? suffix;
  final Color? highlightColor;
  const _HL(this.prefix, this.highlight, this.suffix, this.highlightColor);
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
