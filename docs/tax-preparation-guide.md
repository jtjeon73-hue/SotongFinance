# 세금 준비 가이드

관련: [source-verification-guide.md](source-verification-guide.md) · [source-freshness-guide.md](source-freshness-guide.md) · [practical-finance-standard.md](practical-finance-standard.md)  
콘텐츠: `tax-comprehensive`, `tax-filing`, `tax-capital-gains-real-estate`, `tax-professional`, `re-capital-gains`

**세액을 앱에서 확정하지 않습니다.** 준비자료·일정·공식 확인 흐름만 다룹니다.

## 원칙

1. 세율표·공제액을 사이트에 영구 고정하지 않음 (`versionDependent`)
2. 국세청 안내·공식 계산기·필요 시 세무 전문가
3. `professionalReviewRequired` / `officialCalculatorRecommended` 플래그 존중
4. 민감 증빙은 서버에 올리지 않음

## 종합소득세 (개념·준비)

대상 소득(근로·사업·이자·배당 등)은 **개인 상황에 따라** 다릅니다.

준비 예:

- [ ] 소득·경비 증빙 분류
- [ ] 원천징수·중간예납 기록
- [ ] 공제·세액공제 해당 여부 **공식 확인**
- [ ] 신고·납부 기한 캘린더
- [ ] 자영·농민: 매출≠과세소득, 원가·생활비 분리

## 양도·이전 (부동산 등)

검토 흐름(세액 확정 아님):

양도가 → 취득가 → 필요경비 → 보유·거주 → 주택 수·소재지 → 공제 검토 → 기한 → 증빙

블로그 세율로 “납부액 확정”하지 않습니다. `re-capital-gains` / `tax-capital-gains-real-estate` 체크리스트 사용.

## 상속·증여 (교육 범위)

- 신고·납부 **기한·관할·필요서류**를 공식에서 확인
- 평가·공제·세율은 시점 의존 → 앱에 고정 수치 금지
- 가족·부동산·금융자산 목록은 로컬 점검용으로만
- 분쟁·유언·등기는 법률 전문가 영역으로 분리

## 날짜 메타데이터

모든 세금 콘텐츠에 기록:

| 필드 | 용도 |
|------|------|
| `referenceYear` | 설명 기준 연도 |
| `checkedAt` | 작성자 확인일 |
| `reviewDueAt` | 재확인 기한 (세금은 **짧은 주기**) |
| `verificationStatus` | versionDependent / needsReview / professionalReviewRequired / officialCalculatorRecommended |

UI는 기한 임박·경과 시 재확인 배너를 표시할 수 있습니다 ([source-freshness-guide.md](source-freshness-guide.md)).

## 하지 말 것

- “올해 세율은 항상 X%”처럼 단정
- 절세 상품 가입 권유
- 타인 사례 세액을 내 예상으로 복사
