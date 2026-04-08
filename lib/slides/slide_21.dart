import 'package:flutter/material.dart';

/// Slide 21 — platformio.ini — Configuração Base (3 sub-steps)
class Slide21 extends StatelessWidget {
  final int step;
  const Slide21({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'platformio.ini — Configuração Base',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFFF0F0F0)),
          ),
          const SizedBox(height: 28),
          _RevealBlock(
            visible: step >= 1,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1117),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF3FB950).withValues(alpha: 0.3)),
              ),
              child: SelectableText.rich(
                TextSpan(
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 14, height: 1.6, color: Color(0xFFC9D1D9)),
                  children: [
                    _comment('; platformio.ini\n'),
                    _keyword('[env:esp32-s3-devkitc-1]\n'),
                    _key('platform'), _eq, _val('espressif32\n'),
                    _key('board'), _eq, _val('esp32-s3-devkitc-1\n'),
                    _key('framework'), _eq, _val('espidf\n'),
                    _key('monitor_speed'), _eq, _val('115200\n'),
                    _key('board_build.flash_mode'), _eq, _val('qio\n'),
                    _key('board_build.f_cpu'), _eq, _val('240000000L\n'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 2,
                    child: _InfoBox(
                      title: 'Requisitos Importantes',
                      color: const Color(0xFFFFA657),
                      items: [
                        '✓ Framework: ESP-IDF (não Arduino)',
                        '✓ adc_continuous requer ESP-IDF ≥ 5.0',
                        '✓ Flash QIO para máximo throughput',
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _RevealBlock(
                    visible: step >= 3,
                    child: _InfoBox(
                      title: 'Nota',
                      color: const Color(0xFF8B949E),
                      items: [
                        'A API adc_continuous do ESP-IDF abstrai a configuração do DMA',
                        'O driver reserva internamente os buffers DMA',
                      ],
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

  static const _eq = TextSpan(text: ' = ', style: TextStyle(color: Color(0xFF8B949E)));
  static TextSpan _comment(String t) => TextSpan(text: t, style: const TextStyle(color: Color(0xFF6A9955)));
  static TextSpan _keyword(String t) => TextSpan(text: t, style: const TextStyle(color: Color(0xFFFFA657), fontWeight: FontWeight.w700));
  static TextSpan _key(String t) => TextSpan(text: t, style: const TextStyle(color: Color(0xFF58A6FF)));
  static TextSpan _val(String t) => TextSpan(text: t, style: const TextStyle(color: Color(0xFF3FB950)));
}

class _InfoBox extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> items;
  const _InfoBox({required this.title, required this.color, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 8),
          ...items.map((i) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(i, style: const TextStyle(fontSize: 13, color: Color(0xFFC9D1D9))),
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
