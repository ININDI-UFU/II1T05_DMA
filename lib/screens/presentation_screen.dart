import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/fullscreen_util.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fullscreen_button.dart';
import '../slides/slide_01.dart';
import '../slides/slide_02.dart';
import '../slides/slide_03.dart';
import '../slides/slide_04.dart';
import '../slides/slide_05.dart';
import '../slides/slide_06.dart';
import '../slides/slide_07.dart';
import '../slides/slide_08.dart';
import '../slides/slide_09.dart';
import '../slides/slide_10.dart';
import '../slides/slide_11.dart';
import '../slides/slide_12.dart';
import '../slides/slide_13.dart';
import '../slides/slide_14.dart';
import '../slides/slide_15.dart';
import '../slides/slide_16.dart';
import '../slides/slide_17.dart';
import '../slides/slide_18.dart';
import '../slides/slide_19.dart';
import '../slides/slide_20.dart';
import '../slides/slide_21.dart';
import '../slides/slide_22.dart';
import '../slides/slide_23.dart';
import '../slides/slide_24.dart';
import '../slides/slide_25.dart';
import '../slides/slide_26.dart';
import '../slides/slide_27.dart';
import '../slides/slide_28.dart';

const int kTotalSlides = 28;

const _kAccents = [
  Color(0xFF58A6FF), // blue
  Color(0xFF3FB950), // green
  Color(0xFFD2A8FF), // purple
  Color(0xFFF78166), // red/orange
  Color(0xFFFFA657), // orange
];

const _kGlowPositions = [
  Alignment.topLeft,      // 0  Capa
  Alignment.topRight,     // 1  Seção 01
  Alignment.bottomRight,  // 2  O que é DMA
  Alignment.bottomLeft,   // 3  CPU vs DMA
  Alignment.topCenter,    // 4  Por que DMA
  Alignment.centerRight,  // 5  Seção 02
  Alignment.bottomCenter, // 6  Arquitetura
  Alignment.centerLeft,   // 7  GDMA
  Alignment.topLeft,      // 8  Integração
  Alignment.topRight,     // 9  Seção 03
  Alignment.bottomRight,  // 10 Fluxo Conv
  Alignment.bottomLeft,   // 11 Fluxo DMA
  Alignment.topCenter,    // 12 Gargalos
  Alignment.centerRight,  // 13 Seção 04
  Alignment.bottomCenter, // 14 4 Pilares
  Alignment.centerLeft,   // 15 Exemplos
  Alignment.topLeft,      // 16 Seção 05
  Alignment.topRight,     // 17 ADC+DMA
  Alignment.bottomRight,  // 18 Buffer
  Alignment.bottomLeft,   // 19 Seção 06
  Alignment.topCenter,    // 20 PlatformIO
  Alignment.centerRight,  // 21 Seção 07
  Alignment.bottomCenter, // 22 Código Config
  Alignment.centerLeft,   // 23 Callback
  Alignment.topLeft,      // 24 Fluxo Exec
  Alignment.topRight,     // 25 Seção 08
  Alignment.bottomRight,  // 26 Comparação
  Alignment.bottomLeft,   // 27 Encerramento
];

class PresentationScreen extends StatefulWidget {
  final int initialSlide;
  const PresentationScreen({super.key, this.initialSlide = 0});
  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

int _maxSubStep(int slide) {
  const steps = {
    2: 4,  // Slide03 — O que é DMA (conceito, central, analogia, +1)
    3: 2,  // Slide04 — CPU vs DMA
    4: 3,  // Slide05 — Por que DMA
    6: 3,  // Slide07 — Arquitetura Interna
    7: 3,  // Slide08 — GDMA Detalhes
    8: 2,  // Slide09 — Integração
    10: 2, // Slide11 — Fluxo Convencional
    11: 2, // Slide12 — Fluxo DMA
    12: 3, // Slide13 — Gargalos
    14: 4, // Slide15 — 4 Pilares
    15: 4, // Slide16 — Exemplos
    17: 3, // Slide18 — ADC + DMA
    18: 2, // Slide19 — Buffer Circular
    20: 3, // Slide21 — PlatformIO
    22: 2, // Slide23 — Código Config
    23: 2, // Slide24 — Callback Loop
    24: 6, // Slide25 — Fluxo Execução
    26: 3, // Slide27 — Comparação
  };
  return steps[slide] ?? 0;
}

class _PresentationScreenState extends State<PresentationScreen>
    with TickerProviderStateMixin {
  late int _slide;
  int _subStep = 0;
  bool _forward = true;
  bool _isFS = false;

  late final AnimationController _glowCtrl;
  late final AnimationController _badgeCtrl;
  late final AnimationController _cornerCtrl;

  late Animation<double> _glow1;
  late Animation<double> _glow2;
  late Animation<double> _badge;
  late Animation<double> _corner;

  @override
  void initState() {
    super.initState();
    _slide = widget.initialSlide;

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _badgeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _cornerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _rebuildAnims();
    _glowCtrl.forward();
    _badgeCtrl.forward();
    _cornerCtrl.forward();

    onFullscreenChange((v) {
      if (mounted) setState(() => _isFS = v);
    });
  }

  void _rebuildAnims() {
    _glow1 = CurvedAnimation(
      parent: _glowCtrl,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOutBack),
    );
    _glow2 = CurvedAnimation(
      parent: _glowCtrl,
      curve: const Interval(0.15, 0.8, curve: Curves.easeOutBack),
    );
    _badge = CurvedAnimation(parent: _badgeCtrl, curve: Curves.easeOutBack);
    _corner = CurvedAnimation(
      parent: _cornerCtrl,
      curve: const Interval(0.1, 1.0, curve: Curves.easeOutCubic),
    );
  }

  void _handleNext() {
    final maxSub = _maxSubStep(_slide);
    if (_subStep < maxSub) {
      setState(() => _subStep++);
    } else {
      _goToSlide(_slide + 1, forward: true);
    }
  }

  void _handlePrev() {
    if (_subStep > 0) {
      setState(() => _subStep--);
    } else {
      _goToSlide(_slide - 1, forward: false);
    }
  }

  void _goToSlide(int idx, {required bool forward}) {
    if (idx < 0 || idx >= kTotalSlides) return;
    setState(() {
      _forward = forward;
      _slide = idx;
      _subStep = forward ? 0 : _maxSubStep(idx);
    });
    _restartSlideAnims();
    _updateUrl(idx);
  }

  void _updateUrl(int idx) {
    final uri = '/${idx + 1}';
    Navigator.of(context).pushReplacementNamed(uri);
  }

  void _goTo(int idx) {
    if (idx < 0 || idx >= kTotalSlides || idx == _slide) return;
    _goToSlide(idx, forward: idx > _slide);
  }

  void _restartSlideAnims() {
    _glowCtrl.reset();
    _badgeCtrl.reset();
    _cornerCtrl.reset();
    _rebuildAnims();
    _glowCtrl.forward();
    _badgeCtrl.forward();
    _cornerCtrl.forward();
  }

  Future<void> _toggleFS() async {
    await toggleFullscreen();
    if (mounted) setState(() => _isFS = isFullscreen);
  }

  KeyEventResult _onKey(FocusNode _, KeyEvent e) {
    if (e is! KeyDownEvent) return KeyEventResult.ignored;
    final k = e.logicalKey;
    if (k == LogicalKeyboardKey.arrowRight ||
        k == LogicalKeyboardKey.arrowDown ||
        k == LogicalKeyboardKey.space) {
      _handleNext();
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.arrowLeft || k == LogicalKeyboardKey.arrowUp) {
      _handlePrev();
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.escape && _isFS) {
      _toggleFS();
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.keyF) {
      _toggleFS();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    _badgeCtrl.dispose();
    _cornerCtrl.dispose();
    super.dispose();
  }

  Color get _accent => _kAccents[_slide % _kAccents.length];
  Color get _accent2 => _kAccents[(_slide + 2) % _kAccents.length];

  @override
  Widget build(BuildContext context) {
    final slide = _slide;
    final fwd = _forward;
    final sub = _subStep;

    return Focus(
      autofocus: true,
      onKeyEvent: _onKey,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            _buildBg(),
            _buildGlows(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 80,
              child: _buildSlides(slide, fwd, sub),
            ),
            _buildCornerAccents(),
            Positioned(top: 20, left: 20, child: _buildBadge()),
            Positioned(
              top: 20,
              right: 20,
              child: FullscreenButton(isFullscreen: _isFS, onTap: _toggleFS),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomNavBar(
                currentSlide: _slide,
                totalSlides: kTotalSlides,
                onPrev: _handlePrev,
                onNext: _handleNext,
                onJump: _goTo,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBg() {
    final centers = [
      const Alignment(-0.7, -0.5),
      const Alignment(0.6, -0.4),
      const Alignment(-0.2, 0.6),
      const Alignment(0.5, 0.5),
      const Alignment(0.0, -0.8),
    ];
    final center = centers[_slide % centers.length];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: center,
          radius: 1.6,
          colors: [
            _accent.withValues(alpha: 0.14),
            _accent2.withValues(alpha: 0.04),
            Colors.black,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildGlows() {
    final pos1 = _kGlowPositions[_slide];
    final pos2 = _kGlowPositions[(_slide + 4) % _kGlowPositions.length];

    return AnimatedBuilder(
      animation: _glowCtrl,
      builder: (context, _) {
        final t1 = _glow1.value;
        final t2 = _glow2.value;
        return IgnorePointer(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: pos1,
                child: Opacity(
                  opacity: (t1 * 0.65).clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: 0.2 + t1 * 0.8,
                    child: _GlowBlob(color: _accent, size: 480),
                  ),
                ),
              ),
              Align(
                alignment: pos2,
                child: Opacity(
                  opacity: (t2 * 0.45).clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: 0.2 + t2 * 0.8,
                    child: _GlowBlob(color: _accent2, size: 360),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSlides(int slide, bool fwd, int sub) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 780),
      transitionBuilder: (child, anim) {
        final key = child.key as ValueKey<int>;
        final incoming = key.value == slide;
        return _buildTransition(child, anim, incoming, fwd);
      },
      child: _SlideFrame(
        key: ValueKey<int>(slide),
        slideIndex: slide,
        accent: _accent,
        subStep: sub,
      ),
    );
  }

  Widget _buildTransition(
    Widget child,
    Animation<double> anim,
    bool incoming,
    bool fwd,
  ) {
    final isDiag = _slide % 3 == 2;
    final dy = isDiag ? (fwd ? -0.06 : 0.06) : 0.0;

    if (incoming) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: anim, curve: const Interval(0, 0.45)),
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(fwd ? 1.15 : -1.15, dy),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutQuart)),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.93, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutQuart),
            ),
            child: child,
          ),
        ),
      );
    } else {
      return FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(fwd ? -0.12 : 0.12, fwd ? dy * 0.5 : -dy * 0.5),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInQuart)),
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.06, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeInQuart),
            ),
            child: child,
          ),
        ),
      );
    }
  }

  Widget _buildCornerAccents() {
    return AnimatedBuilder(
      animation: _cornerCtrl,
      builder: (context, _) {
        final t = _corner.value;
        const thickness = 2.0;
        const len = 28.0;
        final color = _accent.withValues(alpha: t * 0.7);
        return IgnorePointer(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 8 + (1 - t) * -30,
                left: 8 + (1 - t) * -30,
                child: Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: _Corner(
                    color: color,
                    thickness: thickness,
                    len: len,
                    quadrant: 0,
                  ),
                ),
              ),
              Positioned(
                top: 8 + (1 - t) * -30,
                right: 8 + (1 - t) * -30,
                child: Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: _Corner(
                    color: color,
                    thickness: thickness,
                    len: len,
                    quadrant: 1,
                  ),
                ),
              ),
              Positioned(
                bottom: 88 + (1 - t) * -30,
                left: 8 + (1 - t) * -30,
                child: Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: _Corner(
                    color: color,
                    thickness: thickness,
                    len: len,
                    quadrant: 2,
                  ),
                ),
              ),
              Positioned(
                bottom: 88 + (1 - t) * -30,
                right: 8 + (1 - t) * -30,
                child: Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: _Corner(
                    color: color,
                    thickness: thickness,
                    len: len,
                    quadrant: 3,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadge() {
    return AnimatedBuilder(
      animation: _badgeCtrl,
      builder: (context, _) {
        final t = _badge.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(-20 * (1 - t), 0),
            child: _SlideBadge(
              current: _slide + 1,
              total: kTotalSlides,
              accent: _accent,
            ),
          ),
        );
      },
    );
  }
}

// ── Slide Frame ─────────────────────────────────────────────────────────────

class _SlideFrame extends StatelessWidget {
  final int slideIndex;
  final Color accent;
  final int subStep;

  const _SlideFrame({
    required super.key,
    required this.slideIndex,
    required this.accent,
    this.subStep = 0,
  });

  @override
  Widget build(BuildContext context) {
    switch (slideIndex) {
      case 0:  return const Slide01();
      case 1:  return const Slide02();
      case 2:  return Slide03(step: subStep);
      case 3:  return Slide04(step: subStep);
      case 4:  return Slide05(step: subStep);
      case 5:  return const Slide06();
      case 6:  return Slide07(step: subStep);
      case 7:  return Slide08(step: subStep);
      case 8:  return Slide09(step: subStep);
      case 9:  return const Slide10();
      case 10: return Slide11(step: subStep);
      case 11: return Slide12(step: subStep);
      case 12: return Slide13(step: subStep);
      case 13: return const Slide14();
      case 14: return Slide15(step: subStep);
      case 15: return Slide16(step: subStep);
      case 16: return const Slide17();
      case 17: return Slide18(step: subStep);
      case 18: return Slide19(step: subStep);
      case 19: return const Slide20();
      case 20: return Slide21(step: subStep);
      case 21: return const Slide22();
      case 22: return Slide23(step: subStep);
      case 23: return Slide24(step: subStep);
      case 24: return Slide25(step: subStep);
      case 25: return const Slide26();
      case 26: return Slide27(step: subStep);
      case 27: return const Slide28();
      default:
        return Center(
          child: Text(
            'Slide ${slideIndex + 1}',
            style: const TextStyle(color: Colors.white38, fontSize: 22),
          ),
        );
    }
  }
}

// ── Glow Blob ───────────────────────────────────────────────────────────────

class _GlowBlob extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.55),
            blurRadius: size * 0.55,
            spreadRadius: size * 0.15,
          ),
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: size * 0.9,
            spreadRadius: size * 0.3,
          ),
        ],
      ),
    );
  }
}

// ── Corner Bracket ──────────────────────────────────────────────────────────

class _Corner extends StatelessWidget {
  final Color color;
  final double thickness;
  final double len;
  final int quadrant;

  const _Corner({
    required this.color,
    required this.thickness,
    required this.len,
    required this.quadrant,
  });

  @override
  Widget build(BuildContext context) {
    final flipX = quadrant == 1 || quadrant == 3;
    final flipY = quadrant == 2 || quadrant == 3;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.diagonal3Values(
        flipX ? -1.0 : 1.0,
        flipY ? -1.0 : 1.0,
        1.0,
      ),
      child: SizedBox(
        width: len,
        height: len,
        child: CustomPaint(
          painter: _CornerPainter(color: color, thickness: thickness),
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  const _CornerPainter({required this.color, required this.thickness});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, 0), Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) =>
      old.color != color || old.thickness != thickness;
}

// ── Slide Badge ─────────────────────────────────────────────────────────────

class _SlideBadge extends StatelessWidget {
  final int current;
  final int total;
  final Color accent;

  const _SlideBadge({
    required this.current,
    required this.total,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: accent.withValues(alpha: 0.35),
              width: 0.5,
            ),
          ),
          child: Text(
            '$current / $total',
            style: TextStyle(
              color: accent,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
