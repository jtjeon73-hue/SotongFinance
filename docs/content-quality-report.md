# 콘텐츠 품질 분석 보고 (2단계)

관련: [finance-content-standard.md](finance-content-standard.md) · [practical-finance-standard.md](practical-finance-standard.md) · [phase2-plan.md](phase2-plan.md)

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

## 등급 정의

| 등급 | 의미 |
|------|------|
| **A** | 실제 재무 의사결정 전 점검자료 수준 (절차·위험·체크리스트·기준일) |
| **B** | 기본 학습 + 일부 실무 요소 |
| **C** | 개념·소개 중심 (1단계 템플릿) |
| **D** | 내용 부족·반복·검증 필요 |

## 규모 요약 (약 174편)

| 등급 | 약 수 | 비고 |
|------|------:|------|
| A | ≈53 | 2단계 수동 보강 (`phase2UpgradedIds`) |
| B | ≈4 | 구조 휴리스틱 통과, 수동 A 미포함 |
| C | ≈115 | 잔여 템플릿 중심 |
| D | ≈2 | 섹션 부족 등 |

**B 예:** `basics-income-expense`, `basics-assets-liabilities`, `mm-couple-finance`, `mm-records-docs`  
**D 예:** `econ-no-realtime`, `fraud-report-police`

C/D 잔여분은 **3단계**에서 실무 보강·전문가 심화 대상입니다.

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

## 3단계로 넘길 일

- C/D ≈117편을 A/B 수준으로 보강
- ETF·대출·경제·용어 연계 페이지의 절차·위험·출처 강화
- 전문가 난이도·제도 변경 이력(로드맵 3단계)
