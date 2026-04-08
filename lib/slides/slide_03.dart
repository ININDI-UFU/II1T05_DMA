import 'package:flutter/material.dart';

/// Slide 03 — O que é DMA? (4 sub-steps)
class Slide03 extends StatelessWidget {
  final int step;
  const Slide03({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'O que é DMA?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Coluna esquerda ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RevealBlock(
                        visible: step >= 1,
                        child: _buildSection(
                          'Direct Memory Access (DMA)',
                          const Color(0xFF58A6FF),
                          'Mecanismo de hardware que permite transferência de dados entre periféricos e memória sem intervenção da CPU.',
                        ),
                      ),
                      const SizedBox(height: 24),
                      _RevealBlock(
                        visible: step >= 2,
                        child: _buildBulletSection(
                          'Conceito Central',
                          const Color(0xFF3FB950),
                          [
                            '▸ Controlador dedicado no barramento do sistema',
                            '▸ Opera em paralelo com a CPU',
                            '▸ Gerencia transferências bloco a bloco automaticamente',
                            '▸ Sinaliza conclusão via interrupção (IRQ)',
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 28),
                // ── Coluna direita ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RevealBlock(
                        visible: step >= 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Analogia',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF78166),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF2D1600,
                                ).withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(
                                    0xFFF78166,
                                  ).withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Text(
                                'Imagine um gerente (CPU) que delega o transporte de caixas a um assistente (DMA), ficando livre para tomar decisões estratégicas.',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFFB0B8C4),
                                  fontStyle: FontStyle.italic,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _RevealBlock(
                        visible: step >= 4,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF0D1F33,
                            ).withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(
                                0xFF58A6FF,
                              ).withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Fluxo de Dados',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF58A6FF),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _miniBlock(
                                    'Periférico',
                                    const Color(0xFFF78166),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xFF58A6FF),
                                    size: 24,
                                  ),
                                  _miniBlock(
                                    'DMA Controller',
                                    const Color(0xFF3FB950),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xFF58A6FF),
                                    size: 24,
                                  ),
                                  _miniBlock(
                                    'Memória (RAM)',
                                    const Color(0xFFD2A8FF),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniBlock(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSection(String title, Color titleColor, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          body,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFFC9D1D9),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBulletSection(
    String title,
    Color titleColor,
    List<String> bullets,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 10),
        ...bullets.map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              b,
              style: const TextStyle(
                fontSize: 17,
                color: Color(0xFFC9D1D9),
                height: 1.4,
              ),
            ),
          ),
        ),
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
