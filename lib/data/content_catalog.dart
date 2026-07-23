import '../models/enums.dart';
import '../models/finance_content.dart';
import 'content_id_mapping.dart';
import 'bond_data.dart';
import 'economy_data.dart';
import 'finance_basics_data.dart';
import 'fraud_prevention_data.dart';
import 'gold_commodity_data.dart';
import 'insurance_data.dart';
import 'loan_credit_data.dart';
import 'money_management_data.dart';
import 'pension_retirement_data.dart';
import 'real_estate_data.dart';
import 'savings_data.dart';
import 'stock_etf_data.dart';
import 'tax_data.dart';

/// 전체 교육 콘텐츠 목록
final allFinanceContent = <FinanceContent>[
  ...financeBasicsContent,
  ...moneyManagementContent,
  ...savingsContent,
  ...realEstateContent,
  ...stockEtfContent,
  ...bondContent,
  ...goldCommodityContent,
  ...insuranceContent,
  ...loanCreditContent,
  ...taxContent,
  ...pensionRetirementContent,
  ...economyContent,
  ...fraudPreventionContent,
];

FinanceContent? getById(String id) {
  final resolved = resolveContentId(id);
  for (final c in allFinanceContent) {
    if (c.id == resolved) return c;
  }
  return null;
}

List<FinanceContent> search(String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return List<FinanceContent>.from(allFinanceContent);
  return allFinanceContent.where((c) {
    if (c.id.toLowerCase().contains(q)) return true;
    if (c.title.toLowerCase().contains(q)) return true;
    if (c.summary.toLowerCase().contains(q)) return true;
    if (c.category.toLowerCase().contains(q)) return true;
    for (final k in c.keywords) {
      if (k.toLowerCase().contains(q)) return true;
    }
    for (final s in c.sections) {
      if (s.heading.toLowerCase().contains(q)) return true;
      if (s.body.toLowerCase().contains(q)) return true;
    }
    return false;
  }).toList();
}

List<FinanceContent> filter({
  String? category,
  Difficulty? difficulty,
  ContentType? contentType,
  LifeStage? lifeStage,
  VerificationStatus? verificationStatus,
}) {
  return allFinanceContent.where((c) {
    if (category != null && c.category != category) return false;
    if (difficulty != null && c.difficulty != difficulty) return false;
    if (contentType != null && c.contentType != contentType) return false;
    if (lifeStage != null && !c.lifeStages.contains(lifeStage)) return false;
    if (verificationStatus != null &&
        c.verificationStatus != verificationStatus) {
      return false;
    }
    return true;
  }).toList();
}

List<String> get allCategories =>
    allFinanceContent.map((c) => c.category).toSet().toList()..sort();

int get contentPageCount => allFinanceContent.length;
