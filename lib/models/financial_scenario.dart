import 'enums.dart';

class FinancialScenario {
  const FinancialScenario({
    required this.id,
    required this.title,
    required this.lifeStage,
    required this.situation,
    required this.goals,
    required this.income,
    required this.expenses,
    required this.assets,
    required this.liabilities,
    required this.insurance,
    required this.pension,
    required this.risks,
    required this.priorities,
    required this.actionOrder,
    required this.reviewCycle,
    required this.contingency,
    this.disclaimer = '교육용 가상 사례입니다. 실제 개인의 조언이 아니며, 가상의 수익성·성공 결과를 보장하지 않습니다.',
  });

  final String id;
  final String title;
  final LifeStage lifeStage;
  final String situation;
  final List<String> goals;
  final String income;
  final String expenses;
  final String assets;
  final String liabilities;
  final String insurance;
  final String pension;
  final List<String> risks;
  final List<String> priorities;
  final List<String> actionOrder;
  final String reviewCycle;
  final List<String> contingency;
  final String disclaimer;
}
