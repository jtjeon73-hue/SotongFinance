import '../models/enums.dart';

/// 콘텐츠/도구의 개인 적용 검증 상태(출처 상태와 별개)
class ApplicationValidationEntry {
  const ApplicationValidationEntry({
    required this.id,
    required this.status,
    required this.note,
  });

  final String id;
  final ApplicationValidationStatus status;
  final String note;
}

const applicationValidationDefaults = <ApplicationValidationEntry>[
  ApplicationValidationEntry(
    id: 'general-education',
    status: ApplicationValidationStatus.deskReviewed,
    note: '일반교육 콘텐츠는 deskReviewed이며 개인 적용 완료가 아님',
  ),
  ApplicationValidationEntry(
    id: 'calculators',
    status: ApplicationValidationStatus.calculationValidated,
    note: '교육용 수식은 단위테스트로 교차검증, 실세액·실연금 아님',
  ),
  ApplicationValidationEntry(
    id: 'tax-pension',
    status: ApplicationValidationStatus.officialCalculatorRequired,
    note: '세금·연금은 공식 계산기/공단 조회 우선',
  ),
  ApplicationValidationEntry(
    id: 'estate-farmland',
    status: ApplicationValidationStatus.professionalReviewRequired,
    note: '상속·농지·법률은 전문가 확인 필요',
  ),
  ApplicationValidationEntry(
    id: 'personal-plan',
    status: ApplicationValidationStatus.userSituationRequired,
    note: 'IPS·인출·배분은 개인 상황 검토 후에만 적용',
  ),
  ApplicationValidationEntry(
    id: 'glossary',
    status: ApplicationValidationStatus.notApplicable,
    note: '용어 페이지는 개인 적용 검증 대상이 아님',
  ),
];

Map<ApplicationValidationStatus, int> countApplicationValidation() {
  final m = <ApplicationValidationStatus, int>{
    for (final s in ApplicationValidationStatus.values) s: 0,
  };
  for (final e in applicationValidationDefaults) {
    m[e.status] = (m[e.status] ?? 0) + 1;
  }
  return m;
}
