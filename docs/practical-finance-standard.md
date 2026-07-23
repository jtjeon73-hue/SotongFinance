# 실무 금융 콘텐츠 작성 표준 (2단계)

관련: [finance-content-standard.md](finance-content-standard.md) · [source-verification-guide.md](source-verification-guide.md) · [privacy-security-guide.md](privacy-security-guide.md)

1단계 필드·금지 표현을 유지하고, **실무 점검에 쓸 수 있는 구조**를 추가합니다.

## 필수 섹션

| 섹션 | 역할 |
|------|------|
| 쉬운 설명 | 한두 문장으로 핵심·오해 방지 |
| 확인할 숫자·계산 흐름 | 공식·표·항목 (허위 고정금리·세율 금지) |
| 실제 점검 절차 | ①②③… 실행 순서 |
| 위험·최악의 경우 | 동시 충격·유동성·연체 등 |
| 잘못된 판단 사례 | 흔한 실패 패턴 |
| 체크리스트 | 복사·인쇄 가능한 점검 항목 |
| 공식 확인·기준일 | `referenceYear`, `checkedAt`, `reviewDueAt` |
| 개인정보·교육용 제한 | 서버 비저장, 추천 금지 고지 |

필요 시 주제별 추가 섹션(비교 관점, 직업별 차이 등)을 넣되, 위 골격은 유지합니다.

## 금지·제한

- 특정 상품·종목·지역 **매수/매도 추천** 없음
- 수익 보장, “손해 없다”, 고정 인출률·고정 자산배분 비율을 보편 정답처럼 제시하지 않음
- 세율·보호한도·LTV/DSR 등을 앱에 **영구 고정 수치**로 박지 않음 → 공식 링크·`versionDependent`
- 민감 재무정보는 **서버에 저장하지 않음** ([privacy-security-guide.md](privacy-security-guide.md))

## 개인차 고지

직업(직장·자영·농민), 가족, 부채, 거주, 건강, 현금흐름 시점에 따라 우선순위가 달라집니다.  
“무조건 N개월 비상자금”, “무조건 전액 상환”처럼 단정하지 말고 **비교 축**을 제시합니다.

## 전문가 검토 플래그

다음이면 `professionalReviewRequired` 또는 `officialCalculatorRecommended`를 사용합니다.

- 양도·종합·상속·증여 등 **세액 확정**에 가까운 판단
- 농지 자격·전용·건축 제한
- 계약·등기·보증금 반환 분쟁 가능 사안
- 국민연금·퇴직연금 **개인별 수령액** 단정

본문은 “준비자료·질문 목록”까지 두고, 확정 세액·가입 권유는 하지 않습니다.

## 메타데이터

기존 표준 필드 + 실무 보강 시 권장:

- `difficulty`: 보통 `practical` (전문가 주제는 `expert`)
- `reviewCycle`: 세금·연금·규제는 더 짧은 주기 ([source-freshness-guide.md](source-freshness-guide.md))
- `checklist`, `nextActions`, `commonMistakes` 채움

## 검수 체크

- [ ] 필수 섹션·체크리스트·출처 ID
- [ ] 추천·보장 문구 없음
- [ ] 개인차·최악 시나리오 명시
- [ ] 세율/한도 변경 가능 고지
- [ ] `reviewDueAt`이 주제 주기에 맞음
