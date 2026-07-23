# 콘텐츠 품질 분석 보고

관련: [finance-content-standard.md](finance-content-standard.md) · [practical-finance-standard.md](practical-finance-standard.md) · [expert-finance-standard.md](expert-finance-standard.md) · [phase2-plan.md](phase2-plan.md) · [cd-content-analysis.json](cd-content-analysis.json)

## 평가 방법 (글자수 아님)

품질은 **구조·실무성·출처·체크리스트**로 판정합니다. 본문 글자수로 A/B/C/D를 나누지 않습니다.

| 기준 | 확인 내용 |
|------|-----------|
| 구조 | 쉬운 설명 · 숫자/계산 · 절차 · 위험 · 잘못된 사례 · 기준일/출처 |
| 실무성 | 실행 순서, 개인차 고지, 고정 추천 금지 |
| 체크리스트 | 행동 가능한 점검 항목 유무 |
| 출처 | `sourceIds`·`verificationStatus`·`reviewDueAt` |

코드 기준 휴리스틱(`content_quality_data.dart`):

1. `phase2UpgradedIds` → **A**
2. 섹션 ≥6 + 체크리스트 + 출처 → **B**
3. 섹션 ≤4 또는 체크리스트 없음 → **D**
4. 그 외 → **C**

### 3단계: 유형별(type-aware) 채점

2단계 휴리스틱을 유지한 채, 보강·검수는 [expert-finance-standard.md](expert-finance-standard.md)의 **콘텐츠 유형** 기준으로 합니다.

- 개념 · 절차 · 비교 · 체크리스트 · 사례 · 세금·제도 · 용어 · 사기예방 — 유형마다 필수 섹션이 다름
- 정확한 **용어(glossary)는 B로 충분** (키워드 스터핑·무리한 A 패딩 금지)
- C/D 잔여 목록·종류별 건수: [cd-content-analysis.json](cd-content-analysis.json) (`tool/cd_analysis.dart` 생성)

A/B/C/D 집계는 아래 **3단계 반영** 표를 기준으로 합니다. 상세는 [phase3-completion-report.md](phase3-completion-report.md).

## 등급 정의

| 등급 | 의미 |
|------|------|
| **A** | 실제 재무 의사결정 전 점검자료 수준 (절차·위험·체크리스트·기준일) |
| **B** | 기본 학습 + 일부 실무 요소 (정확한 용어집 포함) |
| **C** | 개념·소개 중심 (1단계 템플릿) |
| **D** | 내용 부족·반복·검증 필요 |

## 규모 요약 (174편) — 3단계 반영

| 등급 | 수 | 비고 |
|------|------:|------|
| A | 108 | Phase2 53 + Phase3 55 수동 보강 |
| B | 4 | 용어 등 |
| C | 60 | 잔여 개념·소개 (억지 A 금지) |
| D | 2 | 섹션 부족 등 |

### 참고: 2단계 스냅샷

| 등급 | 약 수 |
|------|------:|
| A | ≈53 |
| B | ≈4 |
| C | ≈115 |
| D | ≈2 |

**B 예:** `basics-income-expense`, `basics-assets-liabilities`, `mm-couple-finance`, `mm-records-docs`  
**D 예:** `econ-no-realtime`, `fraud-report-police`

C/D 잔여분(≈117, 분석 JSON 기준)은 **3단계**에서 유형별 실무·전문가 보강 대상입니다.

## 2단계 A등급(≈53) ID — 주제별

### 돈관리·기초 (15)

`mm-household-status`, `mm-monthly-budget`, `mm-fixed-variable`, `mm-emergency-fund`, `mm-debt-payoff`, `mm-financial-goals`, `mm-variable-income`, `mm-annual-review`, `mm-investable-amount`, `mm-insurance-review`, `basics-cashflow`, `basics-net-worth`, `basics-decision`, `basics-risk-return`, `basics-liquidity`

### 부동산 (8)

`re-total-cost`, `re-rental-basics`, `re-buy-rent`, `re-mortgage`, `re-farmland`, `re-jeonse-risk`, `re-capital-gains`, `re-checklist`

### 주식·채권·금·예금·보험 (14)

`stock-basics`, `stock-market-structure`, `stock-per`, `stock-pbr`, `stock-dividend`, `stock-portfolio-risk`, `bond-rate-up-price-down`, `bond-duration`, `gold-inflation-hedge`, `savings-deposit-insurance`, `insurance-not-investment`, `insurance-claim`, `insurance-health`, `insurance-retain-transfer`

### 세금·연금 (12)

`tax-comprehensive`, `tax-filing`, `tax-capital-gains-real-estate`, `tax-professional`, `pension-overview`, `pension-nps-basics`, `pension-nps-estimate`, `pension-retire-account`, `pension-personal`, `pension-gap`, `pension-withdrawal`, `pension-longevity`

### 금융사기 예방 (4)

`fraud-warning-signals`, `fraud-voice-phishing`, `fraud-investment`, `fraud-report-fss`

## 3단계로 넘길 일 / 진행

- C/D ≈117편을 유형별 필수로 A/B 수준 보강 → [expert-finance-standard.md](expert-finance-standard.md)
- ETF·대출·경제·용어 연계의 절차·위험·출처 강화 (용어는 정확성 우선 B)
- 전문가 가이드: IPS·자산배분·행동재무·인출·상증·고령 안전·위기 런북 ([phase3-completion-report.md](phase3-completion-report.md))
- 보강 완료 후 본 문서 등급 표·A ID 목록 갱신
