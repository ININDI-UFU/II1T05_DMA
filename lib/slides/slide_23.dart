import 'package:flutter/material.dart';

/// Slide 23 — Código: Configuração do ADC + DMA (2 sub-steps)
class Slide23 extends StatelessWidget {
  final int step;
  const Slide23({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Código — Configuração do ADC + DMA',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0F0F0),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'ESP-IDF • adc_continuous_config()',
            style: TextStyle(fontSize: 15, color: Color(0xFF8B949E)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _RevealBlock(
              visible: step >= 1,
              child: _CodeBlock(
                code: '''#include "esp_adc/adc_continuous.h"

// Handle global do ADC contínuo
static adc_continuous_handle_t adc_handle = NULL;

// Buffer para resultados
#define ADC_BUFFER_SIZE  256

// Configuração do ADC em modo contínuo + DMA
void init_adc_continuous(void) {
    adc_continuous_handle_cfg_t adc_config = {
        .max_store_buf_size = 1024,
        .conv_frame_size    = ADC_BUFFER_SIZE,
    };
    ESP_ERROR_CHECK(adc_continuous_new_handle(&adc_config,
                                              &adc_handle));

    adc_digi_pattern_config_t adc_pattern = {
        .atten    = ADC_ATTEN_DB_12,
        .channel  = ADC_CHANNEL_0,
        .unit     = ADC_UNIT_1,
        .bit_width = ADC_BITWIDTH_12,
    };

    adc_continuous_config_t dig_cfg = {
        .sample_freq_hz = 20000,  // 20 kHz
        .conv_mode      = ADC_CONV_SINGLE_UNIT_1,
        .format         = ADC_DIGI_OUTPUT_FORMAT_TYPE2,
        .pattern_num    = 1,
        .adc_pattern    = &adc_pattern,
    };
    ESP_ERROR_CHECK(adc_continuous_config(adc_handle,
                                          &dig_cfg));
}''',
              ),
            ),
          ),
          const SizedBox(height: 14),
          _RevealBlock(
            visible: step >= 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF58A6FF).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border(
                  left: BorderSide(color: const Color(0xFF58A6FF), width: 3),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Pontos-chave:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF58A6FF),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '▸ max_store_buf_size — tamanho máximo do pool de buffers DMA internos',
                    style: TextStyle(fontSize: 15, color: Color(0xFFC9D1D9)),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '▸ conv_frame_size — tamanho de cada frame de conversão',
                    style: TextStyle(fontSize: 15, color: Color(0xFFC9D1D9)),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '▸ adc_pattern — seleciona canal, atenuação e resolução',
                    style: TextStyle(fontSize: 15, color: Color(0xFFC9D1D9)),
                  ),
                ],
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
