enum FreshnessLabel {
  upToDate,
  reviewScheduled,
  needsReview,
  officialCalculator,
  professionalReview,
}

extension FreshnessLabelText on FreshnessLabel {
  String get label => switch (this) {
    FreshnessLabel.upToDate => '최신 확인',
    FreshnessLabel.reviewScheduled => '재확인 예정',
    FreshnessLabel.needsReview => '재확인 필요',
    FreshnessLabel.officialCalculator => '공식 계산기 이용',
    FreshnessLabel.professionalReview => '전문가 검토 필요',
  };
}

FreshnessLabel freshnessFor({
  required String reviewDueAt,
  required String verificationStatusName,
  DateTime? now,
}) {
  final n = now ?? DateTime.now();
  if (verificationStatusName == 'officialCalculatorRecommended') {
    return FreshnessLabel.officialCalculator;
  }
  if (verificationStatusName == 'professionalReviewRequired') {
    return FreshnessLabel.professionalReview;
  }
  final due = DateTime.tryParse(reviewDueAt);
  if (due == null) return FreshnessLabel.needsReview;
  if (n.isAfter(due)) return FreshnessLabel.needsReview;
  final days = due.difference(n).inDays;
  if (days <= 45) return FreshnessLabel.reviewScheduled;
  return FreshnessLabel.upToDate;
}

const reviewBannerText = '이 내용은 제도 변경 가능성이 있으므로 최신 공식자료를 다시 확인하세요.';
