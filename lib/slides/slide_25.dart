import 'package:flutter/material.dart';

/// Slide 25 — Fluxo de Execução do Código (6 sub-steps)
class Slide25 extends StatelessWidget {
  final int step;
  const Slide25({super.key, required this.step});

  static const _steps = [
    _FlowStep(
      '1',
      'Inicialização',
      'adc_continuous_new_handle()',
      Color(0xFF58A6FF),
    ),
    _FlowStep(
      '2',
      'Configuração',
      'adc_continuous_config()',
      Color(0xFF3FB950),
    ),
    _FlowStep(
      '3',
      'Registro Callback',
      'adc_continuous_register_event_callbacks()',
      Color(0xFFD2A8FF),
    ),
    _FlowStep('4', 'Iniciar DMA', 'adc_continuous_start()', Color(0xFFFFA657)),
    _FlowStep(
      '5',
      'Aguardar Notificação',
      'ulTaskNotifyTake() — CPU livre',
      Color(0xFFF78166),
    ),
    _FlowStep(
      '6',
      'Ler e Processar',
      'adc_continuous_read() → processar dados',
      Color(0xFF3FB950),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fluxo de Execução do Código',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < _steps.length; i++) ...[
                    _RevealBlock(
                      visible: step >= (i + 1),
                      child: _FlowCard(data: _steps[i]),
                    ),
                    if (i < _steps.length - 1)
                      _RevealBlock(
                        visible: step >= (i + 2),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Icon(
                            Icons.arrow_downward_rounded,
                            color: _steps[i].color.withValues(alpha: 0.5),
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
          _RevealBlock(
            visible: step >= 6,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF3FB950).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF3FB950).withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                'Os passos 5 e 6 se repetem continuamente. A CPU fica livre entre as notificações.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Color(0xFF3FB950)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowStep {
  final String number;
  final String title;
  final String detail;
  final Color color;
  const _FlowStep(this.number, this.title, this.detail, this.color);
}

class _FlowCard extends StatelessWidget {
  final _FlowStep data;
  const _FlowCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: data.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: data.color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: data.color.withValues(alpha: 0.2),
              border: Border.all(color: data.color, width: 1.5),
            ),
            child: Text(
              data.number,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: data.color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: data.color,
                ),
              ),
              Text(
                data.detail,
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Color(0xFFC9D1D9),
                ),
              ),
            ],
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
