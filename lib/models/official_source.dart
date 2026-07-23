import 'enums.dart';

class OfficialSource {
  const OfficialSource({
    required this.id,
    required this.organization,
    required this.title,
    required this.url,
    required this.supports,
    this.referenceYear = '2026',
    this.checkedAt = '2026-07-23',
    this.reviewDueAt = '2026-10-23',
    this.verificationStatus = VerificationStatus.needsReview,
  });

  final String id;
  final String organization;
  final String title;
  final String url;
  final String supports;
  final String referenceYear;
  final String checkedAt;
  final String reviewDueAt;
  final VerificationStatus verificationStatus;
}
