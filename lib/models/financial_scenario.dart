import 'enums.dart';

class FinancialScenario {
  const FinancialScenario({
    required this.id,
    required this.title,
    required this.lifeStage,
    required this.situation,
    required this.goals,
    required this.cashflow,
    required this.income,
    required this.expenses,
    required this.assets,
    required this.liabilities,
    required this.insurance,
    required this.pension,
    required this.realEstate,
    required this.taxNotes,
    required this.risks,
    required this.alternatives,
    required this.stressTests,
    required this.priorities,
    required this.actionOrder,
    required this.reviewCycle,
    required this.changeConditions,
    required this.contingency,
    this.disclaimer = '교육용 가상 사례입니다. 실제 개인의 조언이 아니며, 정답 포트폴리오나 수익을 보장하지 않습니다.',
  });

  final String id;
  final String title;
  final LifeStage lifeStage;
  final String situation;
  final List<String> goals;
  final String cashflow;
  final String income;
  final String expenses;
  final String assets;
  final String liabilities;
  final String insurance;
  final String pension;
  final String realEstate;
  final String taxNotes;
  final List<String> risks;
  final List<String> alternatives;
  final List<String> stressTests;
  final List<String> priorities;
  final List<String> actionOrder;
  final String reviewCycle;
  final List<String> changeConditions;
  final List<String> contingency;
  final String disclaimer;

  String toMarkdown() {
    final buf = StringBuffer()
      ..writeln('# $title')
      ..writeln()
      ..writeln('> $disclaimer')
      ..writeln()
      ..writeln('## 현재상황')
      ..writeln(situation)
      ..writeln()
      ..writeln('## 목표')
      ..writeln(goals.map((e) => '- $e').join('\n'))
      ..writeln()
      ..writeln('## 현금흐름')
      ..writeln(cashflow)
      ..writeln()
      ..writeln('## 소득')
      ..writeln(income)
      ..writeln()
      ..writeln('## 지출')
      ..writeln(expenses)
      ..writeln()
      ..writeln('## 자산')
      ..writeln(assets)
      ..writeln()
      ..writeln('## 부채')
      ..writeln(liabilities)
      ..writeln()
      ..writeln('## 보험')
      ..writeln(insurance)
      ..writeln()
      ..writeln('## 연금')
      ..writeln(pension)
      ..writeln()
      ..writeln('## 부동산')
      ..writeln(realEstate)
      ..writeln()
      ..writeln('## 세금')
      ..writeln(taxNotes)
      ..writeln()
      ..writeln('## 위험')
      ..writeln(risks.map((e) => '- $e').join('\n'))
      ..writeln()
      ..writeln('## 대안(트레이드오프)')
      ..writeln(alternatives.map((e) => '- $e').join('\n'))
      ..writeln()
      ..writeln('## 스트레스 테스트')
      ..writeln(stressTests.map((e) => '- $e').join('\n'))
      ..writeln()
      ..writeln('## 우선순위')
      ..writeln(priorities.map((e) => '- $e').join('\n'))
      ..writeln()
      ..writeln('## 실행순서')
      ..writeln(actionOrder.map((e) => '- $e').join('\n'))
      ..writeln()
      ..writeln('## 점검주기')
      ..writeln(reviewCycle)
      ..writeln()
      ..writeln('## 변경조건')
      ..writeln(changeConditions.map((e) => '- $e').join('\n'))
      ..writeln()
      ..writeln('## 비상 시나리오')
      ..writeln(contingency.map((e) => '- $e').join('\n'));
    return buf.toString();
  }
}
