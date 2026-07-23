# 배포 가이드

## Firebase Hosting

- Project ID: `sotong-finance`
- public: `build/web`
- SPA rewrite: `**` → `/index.html`
- `flutter build web --release` 후 배포

## 로컬 스크립트

```powershell
.\tool\deploy_web.ps1
```

스크립트는 Project ID가 `sotong-finance`인지 검사합니다.

## GitHub Actions

- PR: format, analyze, test, build
- main: 위 + Hosting 배포
- Secret: `FIREBASE_SERVICE_ACCOUNT_SOTONG_FINANCE`

## SPA 직접 경로

하위 경로(`/learn/...`, `/tools/...`)는 Hosting rewrite로 앱이 로드되어야 합니다.
