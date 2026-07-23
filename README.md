# SotongFinance

금융을 처음 배우는 사람부터 은퇴 준비자까지, **돈의 기본 원리·가계관리·저축·부동산·주식·ETF·채권·금·보험·대출·세금·연금**을 체계적으로 학습하는 **금융·자산관리 교육** 사이트입니다.

> **교육용 안내:** SotongFinance는 금융·자산관리 학습을 위한 교육용 정보 사이트입니다. 특정 금융상품·주식·부동산의 매수·매도 추천이나 수익 보장을 제공하지 않습니다. 세금·연금·대출·보험은 개인 상황과 기준일에 따라 달라질 수 있으므로 실제 의사결정 전 공식기관과 전문가에게 확인하세요.

## 주요 이용자

사회초년생, 직장인, 자영업자, 농민, 가족 재무계획자, 중장년, 은퇴 준비자·수급 예정자, 부동산·주식·ETF를 처음 접하는 학습자

## 금융교육 원칙

- 금융교육 중심 / 특정 상품 추천 금지 / 수익 보장·매매 신호 금지
- 과거 수익률 ≠ 미래 수익률
- 세금·법률·연금은 기준연도·확인일 표시
- 계산기는 교육용 추정치, 브라우저 로컬 입력만 사용(서버 비저장)
- 실시간 정보가 아니면 실시간처럼 표시하지 않음

## 메뉴 구조 (1단계)

금융 기초 · 돈 관리 · 예금·적금 · 부동산 · 주식·ETF · 채권 · 금·원자재 · 보험 · 대출·신용 · 세금 · 연금·노후 · 경제와 시장 · 금융사기 예방 · 계산도구 · 금융용어·공식자료 · 프로젝트·배포 기록

## 기술 스택

- Flutter Web (`sotong_finance`)
- go_router, url_launcher, intl
- Firebase Hosting (`sotong-finance`)
- GitHub Actions 자동배포

## 로컬 실행

```bash
flutter pub get
flutter run -d chrome
```

## 검사

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

## Release 빌드

```bash
flutter build web --release
```

출력: `build/web`

## Firebase 배포

Project ID: **sotong-finance** (다른 프로젝트에 배포하지 마세요)

```powershell
.\tool\deploy_web.ps1
```

또는:

```bash
firebase use sotong-finance
firebase deploy --only hosting
```

## 자동배포

`main` push 시 format → analyze → test → web release build → Hosting 배포  
PR에서는 검사·빌드만 수행합니다.

Secret: `FIREBASE_SERVICE_ACCOUNT_SOTONG_FINANCE`

## 개인정보

1단계 계산기 입력값·민감 재무정보는 서버/Firestore에 저장하지 않습니다.

## 단계별 범위

| 단계 | 범위 |
|------|------|
| **1단계** | 입문·기초 콘텐츠, 교육용 계산기 14종, 시나리오·용어·프롬프트·공식출처, Hosting·CI |
| **2단계** | 실무 심화, 생애주기 워크시트, 출처 재검증 자동화 |
| **3단계** | 전문가 심화, (별도 설계 후) 로그인·암호화 개인기록 검토 |

## 운영 주소

https://sotong-finance.web.app

## 문서

- [docs/content-roadmap.md](docs/content-roadmap.md)
- [docs/finance-content-standard.md](docs/finance-content-standard.md)
- [docs/source-verification-guide.md](docs/source-verification-guide.md)
- [docs/calculator-validation-guide.md](docs/calculator-validation-guide.md)
- [docs/privacy-security-guide.md](docs/privacy-security-guide.md)
- [docs/deployment-guide.md](docs/deployment-guide.md)
- [docs/phase1-completion-report.md](docs/phase1-completion-report.md)
