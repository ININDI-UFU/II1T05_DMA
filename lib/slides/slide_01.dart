import 'package:flutter/material.dart';

/// Slide 01 — Capa: DMA na ESP32-S3
class Slide01 extends StatefulWidget {
  const Slide01({super.key});
  @override
  State<Slide01> createState() => _Slide01State();
}

class _Slide01State extends State<Slide01> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Animation<double> _iv(double b, double e) => CurvedAnimation(
    parent: _ctrl,
    curve: Interval(b, e, curve: Curves.easeOutCubic),
  );

  @override
  Widget build(BuildContext context) {
    final chipA = _iv(0.00, 0.40);
    final titleA = _iv(0.15, 0.55);
    final subA = _iv(0.30, 0.65);
    final descA = _iv(0.40, 0.75);
    final tagA = _iv(0.50, 0.85);

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Chip IC animado
              Opacity(
                opacity: chipA.value,
                child: Transform.scale(
                  scale: 0.6 + chipA.value * 0.4,
                  child: const _ChipIcon(),
                ),
              ),
              const SizedBox(height: 24),
              // Título principal
              Opacity(
                opacity: titleA.value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - titleA.value)),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(
                          text: 'DMA',
                          style: TextStyle(color: Color(0xFF58A6FF)),
                        ),
                        TextSpan(
                          text: ' na ',
                          style: TextStyle(color: Color(0xFFF0F0F0)),
                        ),
                        TextSpan(
                          text: 'ESP32-S3',
                          style: TextStyle(color: Color(0xFF3FB950)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Subtítulo
              Opacity(
                opacity: subA.value,
                child: Transform.translate(
                  offset: Offset(0, 16 * (1 - subA.value)),
                  child: const Text(
                    'Direct Memory Access com PlatformIO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFC9D1D9),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Descrição
              Opacity(
                opacity: descA.value,
                child: const Text(
                  'Arquitetura | Fluxo de Dados | Leitura Analógica | Aplicações Práticas',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(0xFF8B949E)),
                ),
              ),
              const SizedBox(height: 10),
              // Tag
              Opacity(
                opacity: tagA.value,
                child: const Text(
                  'Engenharia de Sistemas Embarcados',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF58A6FF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChipIcon extends StatelessWidget {
  const _ChipIcon();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(painter: _ChipPainter()),
    );
  }
}

class _ChipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final bodyPaint = Paint()..color = const Color(0xFF1A2332);
    final borderPaint = Paint()
      ..color = const Color(0xFF58A6FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final pinPaint = Paint()
      ..color = const Color(0xFF58A6FF).withValues(alpha: 0.6)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: c, width: 50, height: 50),
      const Radius.circular(6),
    );
    canvas.drawRRect(bodyRect, bodyPaint);
    canvas.drawRRect(bodyRect, borderPaint);

    // Pins
    const pinLen = 14.0;
    const pinCount = 4;
    for (int i = 0; i < pinCount; i++) {
      final offset = -18.0 + i * 12.0;
      // Top
      canvas.drawLine(
        Offset(c.dx + offset, c.dy - 25),
        Offset(c.dx + offset, c.dy - 25 - pinLen),
        pinPaint,
      );
      // Bottom
      canvas.drawLine(
        Offset(c.dx + offset, c.dy + 25),
        Offset(c.dx + offset, c.dy + 25 + pinLen),
        pinPaint,
      );
      // Left
      canvas.drawLine(
        Offset(c.dx - 25, c.dy + offset),
        Offset(c.dx - 25 - pinLen, c.dy + offset),
        pinPaint,
      );
      // Right
      canvas.drawLine(
        Offset(c.dx + 25, c.dy + offset),
        Offset(c.dx + 25 + pinLen, c.dy + offset),
        pinPaint,
      );
    }

    // DMA text
    final tp = TextPainter(
      text: const TextSpan(
        text: 'DMA',
        style: TextStyle(
          color: Color(0xFF58A6FF),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(c.dx - tp.width / 2, c.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
