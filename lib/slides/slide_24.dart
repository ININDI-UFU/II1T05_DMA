import 'package:flutter/material.dart';

/// Slide 24 — Código: Callback e Loop Principal (2 sub-steps)
class Slide24 extends StatelessWidget {
  final int step;
  const Slide24({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Código — Callback e Loop Principal',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'ESP-IDF • Callback de conversão + app_main()',
            style: TextStyle(fontSize: 15, color: Color(0xFF8B949E)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _RevealBlock(
              visible: step >= 1,
              child: _CodeBlock(
                code:
                    '''// Callback chamado quando um frame de conversão está pronto
static bool IRAM_ATTR adc_conv_done_cb(
        adc_continuous_handle_t handle,
        const adc_continuous_evt_data_t *edata,
        void *user_data) {
    // Sinaliza a task principal (via semáforo, task notification, etc.)
    BaseType_t high_task_woken = pdFALSE;
    vTaskNotifyGiveFromISR(main_task_handle, &high_task_woken);
    return (high_task_woken == pdTRUE);
}''',
              ),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: _RevealBlock(
              visible: step >= 2,
              child: _CodeBlock(
                code: '''void app_main(void) {
    init_adc_continuous();

    adc_continuous_evt_cbs_t cbs = {
        .on_conv_done = adc_conv_done_cb,
    };
    ESP_ERROR_CHECK(adc_continuous_register_event_callbacks(
                        adc_handle, &cbs, NULL));

    ESP_ERROR_CHECK(adc_continuous_start(adc_handle));

    uint8_t result[ADC_BUFFER_SIZE] = {0};
    uint32_t ret_num = 0;

    while (true) {
        ulTaskNotifyTake(pdTRUE, portMAX_DELAY);

        if (adc_continuous_read(adc_handle, result,
                ADC_BUFFER_SIZE, &ret_num, 0) == ESP_OK) {
            // Processar dados em result[]
            for (int i = 0; i < ret_num; i += SOC_ADC_DIGI_RESULT_BYTES) {
                adc_digi_output_data_t *p =
                    (adc_digi_output_data_t *)&result[i];
                ESP_LOGI("ADC", "Ch: %d  Val: %d",
                         p->type2.channel, p->type2.data);
            }
        }
    }
}''',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF3FB950).withValues(alpha: 0.3),
        ),
      ),
      child: SingleChildScrollView(
        child: SelectableText(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            height: 1.5,
            color: Color(0xFFC9D1D9),
          ),
        ),
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
