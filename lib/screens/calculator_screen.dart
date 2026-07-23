import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constants/app_constants.dart';
import '../data/calculator_catalog.dart';
import '../models/calculator_definition.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/copy_button.dart';
import '../widgets/disclaimer_banner.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key, required this.calcId});

  final String calcId;

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late final Map<String, TextEditingController> _controllers;
  CalculatorResult? _result;
  String? _error;

  CalculatorDefinition? get _def =>
      calculatorCatalog.where((c) => c.id == widget.calcId).firstOrNull;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    final def = _def;
    _controllers = {};
    if (def != null) {
      for (final f in def.fields) {
        _controllers[f.key] = TextEditingController(text: f.defaultValue);
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  double? _parseField(String key) {
    final raw = _controllers[key]?.text ?? '';
    final cleaned = raw.replaceAll(',', '').trim();
    if (cleaned.isEmpty) return null;
    return double.tryParse(cleaned);
  }

  Map<String, double> _values() {
    final map = <String, double>{};
    for (final entry in _controllers.entries) {
      map[entry.key] = _parseField(entry.key) ?? 0;
    }
    return map;
  }

  void _compute() {
    setState(() {
      _error = null;
      _result = null;
      final def = _def;
      if (def == null) {
        _error = '계산기를 찾을 수 없습니다.';
        return;
      }
      for (final f in def.fields) {
        final v = _parseField(f.key);
        if (v == null && (f.defaultValue.isEmpty)) {
          _error = '${f.label}(${f.unit}) 값을 입력하세요.';
          return;
        }
      }
      final result = runCalculator(widget.calcId, _values());
      if (result == null) {
        _error = '계산할 수 없습니다.';
        return;
      }
      if (result.summary.contains('계산할 수 없')) {
        _error = result.details.join('\n');
      }
      _result = result;
    });
  }

  void _reset() {
    setState(() {
      _result = null;
      _error = null;
      for (final f in _def!.fields) {
        _controllers[f.key]?.text = f.defaultValue;
      }
    });
  }

  void _fillExample() {
    final def = _def;
    if (def == null) return;
    const examples = <String, Map<String, String>>{
      'calc-net-worth': {'assets': '100000000', 'liabilities': '30000000'},
      'calc-cashflow': {'income': '3000000', 'expenses': '2500000'},
      'calc-savings-rate': {'income': '4000000', 'savings': '800000'},
      'calc-simple': {'principal': '10000000', 'rate': '3', 'years': '2'},
      'calc-compound': {
        'principal': '10000000',
        'rate': '5',
        'years': '10',
        'n': '1',
      },
      'calc-real-return': {'nominal': '5', 'inflation': '2'},
      'calc-loan-payment': {
        'principal': '100000000',
        'rate': '4',
        'months': '360',
      },
      'calc-equal-payment': {
        'principal': '50000000',
        'rate': '5',
        'months': '60',
      },
      'calc-equal-principal': {
        'principal': '50000000',
        'rate': '5',
        'months': '60',
      },
      'calc-invest-return': {'buy': '1000000', 'sell': '1100000'},
      'calc-rental-yield': {'rent': '6000000', 'price': '200000000'},
      'calc-retirement-gap': {'needed': '500000000', 'expected': '350000000'},
      'calc-pension-sum': {
        'nps': '800000',
        'retire': '500000',
        'personal': '300000',
        'other': '0',
      },
      'calc-future-cost': {
        'current': '2000000',
        'inflation': '2',
        'years': '20',
      },
    };
    final ex = examples[widget.calcId];
    if (ex != null) {
      for (final e in ex.entries) {
        _controllers[e.key]?.text = e.value;
      }
    }
    setState(() {
      _result = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final def = _def;
    if (def == null) {
      return const Center(child: Text('계산기를 찾을 수 없습니다.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '계산도구', route: '/tools'),
            BreadcrumbItem(label: '계산기'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          def.title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(def.purpose),
        const SizedBox(height: 12),
        const DisclaimerBanner(compact: true),
        const SizedBox(height: 8),
        Text(
          AppConstants.calculatorDisclaimer,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          AppConstants.noServerStorageNotice,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 20),
        ...def.fields.map(
          (f) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextField(
              controller: _controllers[f.key],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.,\-]')),
              ],
              decoration: InputDecoration(
                labelText: '${f.label} (${f.unit})',
                hintText: f.hint,
                suffixText: f.unit,
              ),
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(onPressed: _compute, child: const Text('계산')),
            OutlinedButton(onPressed: _reset, child: const Text('초기화')),
            OutlinedButton(onPressed: _fillExample, child: const Text('예시 입력')),
          ],
        ),
        if (_error != null) ...[
          const SizedBox(height: 16),
          Text(
            _error!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
        if (_result != null) ...[
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _result!.summary,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (_result!.copyText.isNotEmpty)
                        CopyTextButton(text: _result!.copyText, label: '결과 복사'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._result!.details.map(
                    (d) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text('• $d'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 20),
        _InfoBlock(title: '공식', body: def.formula),
        if (def.example != null) _InfoBlock(title: '예시', body: def.example!),
        _InfoBlock(
          title: '한계·주의',
          body: def.limitations.map((e) => '• $e').join('\n'),
        ),
      ],
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(body),
            ],
          ),
        ),
      ),
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final it = iterator;
    return it.moveNext() ? it.current : null;
  }
}
