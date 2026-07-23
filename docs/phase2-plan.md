# 2단계 계획 및 진행 현황

관련: [content-roadmap.md](content-roadmap.md) · [phase1-completion-report.md](phase1-completion-report.md) · [phase2-completion-report.md](phase2-completion-report.md)

1단계(커밋 `088f2ec`) 이후 **실무 심화**. 목표: 점검 가능한 콘텐츠·계산기·경로·신선도·진단.

## 원칙 (유지)

- [x] 상품·종목 추천 없음
- [x] 허위·고정 금리·세율 제시 없음
- [x] 개인 재무 데이터 서버 비저장
- [x] Firebase `sotong-finance` / Hosting https://sotong-finance.web.app

## 계획 항목

### 콘텐츠 품질

- [x] 실무 작성 표준 문서화 → [practical-finance-standard.md](practical-finance-standard.md)
- [x] ≈53편 수동 A등급 보강 (`phase2UpgradedIds` / overrides)
- [x] 등급 휴리스틱·보고 → [content-quality-report.md](content-quality-report.md)
- [ ] 잔여 C/D ≈117편 A/B화 → **3단계**

### 계산기·진단

- [x] 교육용 계산기 27종 (기존 14 + 신규 13)
- [x] 수식 검증 원칙 유지 → [calculator-validation-guide.md](calculator-validation-guide.md)
- [x] 로컬 전용 교육용 재무진단 (`/diagnose`)

### 프롬프트·출처·신선도

- [x] 분석 프롬프트 ≈37
- [x] 출처 검증 상태 유지 → [source-verification-guide.md](source-verification-guide.md)
- [x] `reviewDueAt` / `FreshnessLabel` → [source-freshness-guide.md](source-freshness-guide.md)
- [ ] 공식출처 목록 18건에서 추가 확대 → **진행 중 / 3단계 연계**

### 생애주기·주제 가이드

- [x] 생애주기 학습 경로 (`/paths`)
- [x] 가계·부동산·투자위험·세금준비·연금·변동소득 가이드 문서화

### 배포·품질게이트

- [x] Hosting·Actions 절차 → [deployment-guide.md](deployment-guide.md)
- [ ] 2단계 완료 커밋 해시·Actions 최종 상태 기록 → [phase2-completion-report.md](phase2-completion-report.md) 플레이스홀더

## 규모 스냅샷

| 항목 | 1단계 | 2단계(현재) |
|------|------:|------------:|
| 학습 콘텐츠 | 174 | 174 (ID 유지, ≈53 보강) |
| 계산기 | 14 | 27 |
| 프롬프트 | 15+ | ≈37 |
| 공식 출처 | 18 | 18 (확대 예정) |

## 완료 정의 (DoD)

- A등급 핵심 주제(가계·부동산·투자위험·세금·연금·변동소득·사기예방) 보강
- 계산기 27·진단·경로·신선도 UI 동작
- docs 가이드·완료 보고(초안) 정리
- analyze / test / web build 통과 후 배포 확인

잔여 템플릿 전부 A화는 2단계 DoD에 **포함하지 않음** (3단계).
