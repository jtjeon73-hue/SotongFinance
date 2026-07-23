# SotongFinance 3단계 완료 보고

관련: [phase2-completion-report.md](phase2-completion-report.md) · [content-roadmap.md](content-roadmap.md) · [expert-finance-standard.md](expert-finance-standard.md) · [content-quality-report.md](content-quality-report.md) · [deployment-guide.md](deployment-guide.md)

## 저장소

| 항목 | 값 |
|------|-----|
| 작업 폴더 | `C:\Users\user\Documents\GitHub\SotongFinance` |
| Git remote | `https://github.com/jtjeon73-hue/SotongFinance.git` |
| 브랜치 | `main` |
| **2단계 기준 커밋** | `fc4cfb8` |
| **3단계 기준 커밋** | `4aea013744ce7562b8b067e41cda0aceec4c8484` |
| 1단계 기준 커밋 | `088f2ec` |
| Firebase Project ID | `sotong-finance` |
| 운영 주소 | https://sotong-finance.web.app |

## 구축 요약

Flutter Web 금융교육 **3단계: 전문가 심화**.

- 유형별 품질판정 + Phase3 수동 보강 55개 (Phase2 53과 합산 A≈108)
- IPS · 재무계획 16단계 · 위기대응 · 연간점검 · 제도 타임라인 · 상속목록
- 전문가 계산기 확장(전체 37) · 프롬프트 57 · 심화 사례 12
- 큰 글씨 · 쉬운 금융 경로/필터 · 개인정보 비저장 검증
- 원칙 유지: 추천 없음 · 허위 금리 없음 · 개인재무 서버 비저장 · `sotong-finance`만

## 규모

| 항목 | 수 | 비고 |
|------|-----|------|
| 학습 콘텐츠 | 174 | ID 유지 |
| A / B / C / D | **108 / 4 / 60 / 2** | 잔여 C/D는 역할상 개념·용어 등, 억지 A 금지 |
| Phase2 / Phase3 보강 | 53 / 55 | 수동 |
| C/D 분석 | 62 잔여 | [cd-content-analysis.json](cd-content-analysis.json) 스냅샷 갱신 가능 |
| 계산기 | 37 | 전문가 도구 포함 |
| 프롬프트 | 57 | 50–60 범위 |
| 공식 출처 | 24 | verified 7 등 |
| 사례 | 12 | 15필드 심화 |
| 생애주기 경로 | 13 | 쉬운 금융(고령) 포함 |

## 검사 (로컬)

| 검사 | 결과 |
|------|------|
| dart format | 통과 |
| flutter analyze --fatal-infos | 통과 |
| flutter test | 63+ passed (갱신 후 재확인) |
| flutter build web --release | 통과 |
| 반응형 E2E | push·배포 후 `tool/e2e/responsive_check.mjs` |

## GitHub Actions — 실행 후 기입

| 항목 | 값 |
|------|-----|
| 워크플로 실행 URL | `________` |
| PR / main 배포 상태 | `________` |
| Secret `FIREBASE_SERVICE_ACCOUNT_SOTONG_FINANCE` | 기존 유지(변경·재생성 없음) |

## 개인정보

계산기·진단·워크시트 입력은 브라우저 로컬만. Firestore/Analytics에 재무 입력 저장·전송 없음.  
→ [privacy-review.md](privacy-review.md) · [privacy-security-guide.md](privacy-security-guide.md)

## 문서 인덱스 (3단계)

- [expert-finance-standard.md](expert-finance-standard.md)
- [investment-policy-guide.md](investment-policy-guide.md)
- [asset-allocation-risk-guide.md](asset-allocation-risk-guide.md)
- [behavioral-finance-guide.md](behavioral-finance-guide.md)
- [retirement-withdrawal-guide.md](retirement-withdrawal-guide.md)
- [tax-estate-preparation-guide.md](tax-estate-preparation-guide.md)
- [elderly-finance-safety-guide.md](elderly-finance-safety-guide.md)
- [financial-crisis-runbook.md](financial-crisis-runbook.md)
- [privacy-review.md](privacy-review.md)
- [content-quality-report.md](content-quality-report.md) · [cd-content-analysis.json](cd-content-analysis.json)

## 남은 확인

- 세금·연금·대출규제 versionDependent 공식 재대조
- 잔여 C/D는 역할상 유지(억지 A 금지)
- 상속·농지·세무 professionalReviewRequired
- 개인 상황 적용은 userSituationRequired

## 완료 판정

품질 게이트·커밋·push·Actions·Hosting 확인 후 3단계 커밋 해시와 Actions URL을 기입한다.
