import 'package:flutter/material.dart';

/// Slide 27 — Comparação: Polling vs Interrupt vs DMA (3 sub-steps)
class Slide27 extends StatelessWidget {
  final int step;
  const Slide27({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Comparação: Polling vs Interrupt vs DMA',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 28),
          // Header
          _TableHeader(),
          const SizedBox(height: 1),
          // Rows
          _RevealBlock(
            visible: step >= 1,
            child: _TableRow(
              method: 'Polling',
              color: const Color(0xFFF78166),
              cpu: 'Alta (busy-wait)',
              throughput: 'Baixo',
              latency: 'Variável',
              complexity: 'Baixa',
              realTime: '✗',
            ),
          ),
          const SizedBox(height: 1),
          _RevealBlock(
            visible: step >= 2,
            child: _TableRow(
              method: 'Interrupt',
              color: const Color(0xFFFFA657),
              cpu: 'Média (ISR overhead)',
              throughput: 'Médio',
              latency: 'Baixa (µs)',
              complexity: 'Média',
              realTime: '△',
            ),
          ),
          const SizedBox(height: 1),
          _RevealBlock(
            visible: step >= 3,
            child: _TableRow(
              method: 'DMA',
              color: const Color(0xFF3FB950),
              cpu: 'Mínima (~0%)',
              throughput: 'Máximo',
              latency: 'Determinística',
              complexity: 'Maior',
              realTime: '✓',
            ),
          ),
          const Spacer(),
          _RevealBlock(
            visible: step >= 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF3FB950).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF3FB950).withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                'Para aplicações de alta frequência e tempo real, DMA é a escolha ideal — libera a CPU e garante aquisição determinística.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3FB950),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Método',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8B949E),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Uso CPU',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8B949E),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Throughput',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8B949E),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Latência',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8B949E),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Complex.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8B949E),
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              'RT',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8B949E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final String method;
  final Color color;
  final String cpu;
  final String throughput;
  final String latency;
  final String complexity;
  final String realTime;
  const _TableRow({
    required this.method,
    required this.color,
    required this.cpu,
    required this.throughput,
    required this.latency,
    required this.complexity,
    required this.realTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        border: Border(
          left: BorderSide(color: color, width: 3),
          bottom: BorderSide(
            color: const Color(0xFF30363D).withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              method,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              cpu,
              style: const TextStyle(fontSize: 13, color: Color(0xFFC9D1D9)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              throughput,
              style: const TextStyle(fontSize: 13, color: Color(0xFFC9D1D9)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              latency,
              style: const TextStyle(fontSize: 13, color: Color(0xFFC9D1D9)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              complexity,
              style: const TextStyle(fontSize: 13, color: Color(0xFFC9D1D9)),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              realTime,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: color),
            ),
          ),
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
