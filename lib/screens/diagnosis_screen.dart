import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constants/app_constants.dart';
import '../services/diagnosis_service.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/disclaimer_banner.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  final _controllers = <String, TextEditingController>{
    for (final k in [
      'income',
      'essential',
      'expense',
      'cash',
      'assets',
      'debt',
      'payment',
      'pension',
      'years',
    ])
      k: TextEditingController(),
  };

  DiagnosisResult? _result;

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  double _v(String key) =>
      double.tryParse(_controllers[key]!.text.replaceAll(',', '')) ?? 0;

  void _run() {
    setState(() {
      _result = runDiagnosis(
        DiagnosisInput(
          monthlyIncome: _v('income'),
          monthlyEssential: _v('essential'),
          monthlyTotalExpense: _v('expense'),
          cashLike: _v('cash'),
          totalAssets: _v('assets'),
          totalLiabilities: _v('debt'),
          monthlyDebtPayment: _v('payment'),
          monthlyPensionSum: _v('pension'),
          yearsToRetire: _v('years'),
        ),
      );
    });
  }

  void _reset() {
    for (final c in _controllers.values) {
      c.clear();
    }
    setState(() => _result = null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '교육용 재무진단'),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '교육용 재무진단',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          '입력값은 이 브라우저 화면에만 있으며 서버·Firestore·로그에 저장하지 않습니다. '
          '좋음/나쁨을 단정하지 않으며 투자·상품 추천이 없습니다.',
        ),
        const SizedBox(height: 12),
        const DisclaimerBanner(compact: true),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _field('income', '월평균 소득', '원'),
            _field('essential', '월 필수지출', '원'),
            _field('expense', '월 총지출', '원'),
            _field('cash', '현금성자산', '원'),
            _field('assets', '총자산', '원'),
            _field('debt', '총부채', '원'),
            _field('payment', '월 대출상환', '원'),
            _field('pension', '연금 월예상합계', '원'),
            _field('years', '은퇴까지 기간', '년'),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: [
            Semantics(
              button: true,
              label: '재무진단 실행',
              child: ElevatedButton(
                onPressed: _run,
                child: const Text('진단 실행'),
              ),
            ),
            Semantics(
              button: true,
              label: '입력 초기화',
              child: OutlinedButton(
                onPressed: _reset,
                child: const Text('초기화'),
              ),
            ),
            if (_result != null)
              Semantics(
                button: true,
                label: '진단 결과 복사',
                child: OutlinedButton(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: _result!.copyText),
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('결과를 복사했습니다')),
                      );
                    }
                  },
                  child: const Text('결과 복사'),
                ),
              ),
          ],
        ),
        if (_result != null) ...[
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('월 현금흐름: ${_result!.cashFlow.round()}원'),
                  Text(
                    '저축률: ${_result!.savingsRate?.toStringAsFixed(1) ?? "-"}%',
                  ),
                  Text('순자산: ${_result!.netWorth.round()}원'),
                  Text(
                    '부채비중: ${_result!.debtRatio?.toStringAsFixed(1) ?? "-"}%',
                  ),
                  Text(
                    '비상자금개월: ${_result!.emergencyMonths?.toStringAsFixed(1) ?? "-"}',
                  ),
                  Text(
                    '상환부담: ${_result!.paymentBurden?.toStringAsFixed(1) ?? "-"}%',
                  ),
                  const SizedBox(height: 12),
                  ..._result!.notes.map(
                    (n) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text('· $n'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        Text(
          AppConstants.noServerStorageNotice,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _field(String key, String label, String unit) {
    return SizedBox(
      width: 260,
      child: TextField(
        controller: _controllers[key],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: '$label ($unit)',
          helperText: '단위: $unit',
        ),
      ),
    );
  }
}
