# 출처·콘텐츠 신선도 가이드

관련: [source-verification-guide.md](source-verification-guide.md) · [finance-content-standard.md](finance-content-standard.md)

공식 URL 존재만으로 “최신”이 아닙니다. **재확인 기한**과 **검증 상태**로 UI 라벨을 정합니다.

## 1. `reviewDueAt`

콘텐츠·출처에 ISO 날짜(`YYYY-MM-DD`)로 둡니다.

- 작성·확인 시 `checkedAt`과 함께 갱신
- 기한이 지나면 재확인 필요
- 세금·연금·대출규제·예금자보호·농지·전세보증 등은 **더 짧게**

권장 주기(가이드):

| 주제 | 권장 `reviewDueAt` 간격 |
|------|-------------------------|
| 세금·신고 절차 | 분기 또는 법령 시즌 전 |
| 연금·건보·퇴직제도 | 분기~반기 |
| LTV/DSR·보호한도 | 분기 |
| 일반 개념·행동지침 | 반기~연 |
| 사기 신고 연락처·절차 | 분기 (`needsReview` 병행) |

## 2. `FreshnessLabel` (코드: `lib/core/utils/freshness.dart`)

| 라벨 | 한글 | 조건(요약) |
|------|------|------------|
| `upToDate` | 최신 확인 | 기한까지 여유(>45일) |
| `reviewScheduled` | 재확인 예정 | 기한까지 ≤45일 |
| `needsReview` | 재확인 필요 | 기한 경과 또는 파싱 실패 |
| `officialCalculator` | 공식 계산기 이용 | 상태가 officialCalculatorRecommended |
| `professionalReview` | 전문가 검토 필요 | 상태가 professionalReviewRequired |

배너 문구 예: “이 내용은 제도 변경 가능성이 있으므로 최신 공식자료를 다시 확인하세요.”

## 3. `VerificationStatus` (검증 상태)

| 상태 | 의미 |
|------|------|
| `verified` | 공식 설명이 내용을 뒷받침 |
| `versionDependent` | 수치·한도·규제가 시점 의존 |
| `needsReview` | 절차·연락처 등 재확인 |
| `officialCalculatorRecommended` | 공식 계산기 사용 |
| `professionalReviewRequired` | 세무·법률 등 전문가 |
| `educationalExample` | 교육용 예시 |

신선도 라벨과 검증 상태는 **함께** 봅니다. 기한이 남아 있어도 `versionDependent`면 수치를 확정하지 않습니다.

## 4. 운영 체크

- [ ] 세금·연금 페이지 `reviewDueAt`이 짧게 설정됨
- [ ] 공식 계산기 주제는 해당 상태 + 링크
- [ ] 기한 갱신 시 `checkedAt`·출처 URL 동시 점검
- [ ] 출처 확대 시에도 동일 메타 적용 ([phase2-plan.md](phase2-plan.md))
