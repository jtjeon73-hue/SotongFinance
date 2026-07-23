# SotongFinance 2단계 완료 보고 (초안)

관련: [phase1-completion-report.md](phase1-completion-report.md) · [phase2-plan.md](phase2-plan.md) · [deployment-guide.md](deployment-guide.md) · [content-quality-report.md](content-quality-report.md)

## 저장소

| 항목 | 값 |
|------|-----|
| 작업 폴더 | `C:\Users\user\Documents\GitHub\SotongFinance` |
| Git remote | `https://github.com/jtjeon73-hue/SotongFinance.git` |
| 브랜치 | `main` (확인 필요) |
| **2단계 기준 커밋** | `6aef3cf6ce1a397acd079dd25684649c6fece4ce` |
| 1단계 기준 커밋 | `088f2ec` |
| Firebase Project ID | `sotong-finance` |
| 운영 주소 | https://sotong-finance.web.app |

## 구축 요약

Flutter Web 금융교육 **2단계: 실무 심화**.

- 기존 174콘텐츠 ID 유지, ≈53편 수동 A등급 보강
- 교육용 계산기 27종(14+13), 프롬프트 ≈37
- 생애주기 경로, 로컬 재무진단, 출처 신선도(`reviewDueAt` / `FreshnessLabel`)
- 실무·주제 가이드 docs 추가
- 원칙 유지: 추천 없음 · 허위 금리 없음 · 개인재무 서버 비저장

## 규모

| 항목 | 수 |
|------|-----|
| 학습 콘텐츠 | 174 (A≈53 / B≈4 / C≈115 / D≈2) |
| 계산기 | 27 |
| 프롬프트 | ≈37 |
| 공식 출처 | 24 |
| 생애주기 경로 | 12 |
| 교육용 재무진단 | `/diagnose` (로컬 비저장) |

## 검사 (로컬)

| 검사 | 결과 |
|------|------|
| dart format | 통과 |
| flutter analyze --fatal-infos | 통과 |
| flutter test | 55 passed |
| flutter build web --release | 통과 |
| 반응형 E2E | push·배포 후 `tool/e2e/responsive_check.mjs` |

## GitHub Actions — 실행 후 기입

| 항목 | 값 |
|------|-----|
| 워크플로 실행 URL | `________` |
| PR / main 배포 상태 | `________` (success / failure / skipped) |
| Secret `FIREBASE_SERVICE_ACCOUNT_SOTONG_FINANCE` | 등록 여부 `________` |

## 개인정보

계산기·진단 입력은 브라우저 로컬(메모리)만 사용. 서버·Firestore 저장 없음.  
→ [privacy-security-guide.md](privacy-security-guide.md)

## 문서 인덱스 (2단계)

- [phase2-plan.md](phase2-plan.md)
- [practical-finance-standard.md](practical-finance-standard.md)
- [content-quality-report.md](content-quality-report.md)
- [household-finance-guide.md](household-finance-guide.md)
- [real-estate-cost-guide.md](real-estate-cost-guide.md)
- [investment-risk-guide.md](investment-risk-guide.md)
- [tax-preparation-guide.md](tax-preparation-guide.md)
- [pension-retirement-guide.md](pension-retirement-guide.md)
- [variable-income-guide.md](variable-income-guide.md)
- [source-freshness-guide.md](source-freshness-guide.md)

## 남은 일 (3단계·운영)

- C/D 잔여 콘텐츠 실무 보강
- 공식출처 목록 확대
- versionDependent 세금·연금·대출 규제 정기 재확인
- Actions·Hosting 최종 상태 위 표에 확정 기입
- (보안·개인정보 영향평가 후) 선택적 개인기록은 3단계 이후

## 완료 판정

계획 DoD([phase2-plan.md](phase2-plan.md)) 충족 시 본 문서의 커밋 해시·Actions 칸을 채우고 “초안” 표기를 제거합니다.
