# SotongFinance 1단계 완료 보고

## 저장소

- 작업 폴더: `C:\Users\user\Documents\GitHub\SotongFinance`
- Git remote: `https://github.com/jtjeon73-hue/SotongFinance.git`
- 브랜치: `main`
- Firebase Project ID: `sotong-finance`
- 운영 주소: https://sotong-finance.web.app

## 구축 요약

Flutter Web 금융교육 플랫폼 1단계. 입문·기초 콘텐츠, 교육용 계산기 14종, 시나리오·용어·프롬프트·공식출처, 검색·필터, 반응형 셸, Hosting 수동 배포, GitHub Actions workflow.

## 규모

| 항목 | 수 |
|------|-----|
| 학습 콘텐츠 | 174 |
| 계산기 | 14 |
| 시나리오 | 10 |
| 용어 | 40+ |
| 프롬프트 | 15+ |
| 공식 출처 | 18 |

## 검사 (로컬)

- dart format: 통과
- flutter analyze --fatal-infos: 통과
- flutter test: 32 passed
- flutter build web --release: 통과
- Hosting SPA 직접 경로: 200 OK

## 개인정보

계산기 입력은 브라우저 로컬만 사용. 서버 저장 없음.

## 남은 검토

- versionDependent 세금·연금·대출 규제 공식 재확인
- GitHub Secret `FIREBASE_SERVICE_ACCOUNT_SOTONG_FINANCE` 등록 및 Actions 배포 확인

## 2·3단계

- 2단계: 실무 심화, 출처 만료 알림, 생애주기 경로
- 3단계: 전문가 심화, (보안 검토 후) 선택적 개인기록
