# Deploy Flutter Web to Firebase Hosting (sotong-finance only)
$ErrorActionPreference = "Stop"
$ExpectedProject = "sotong-finance"

Write-Host "== SotongFinance Web Deploy =="

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  throw "flutter CLI not found"
}
if (-not (Get-Command firebase -ErrorAction SilentlyContinue)) {
  throw "firebase CLI not found"
}

$current = (firebase use 2>&1 | Out-String)
Write-Host $current
if ($current -notmatch $ExpectedProject) {
  Write-Host "Switching to $ExpectedProject..."
  firebase use $ExpectedProject
}

$after = (firebase use 2>&1 | Out-String)
if ($after -notmatch $ExpectedProject) {
  throw "Refusing to deploy: active Firebase project is not $ExpectedProject"
}

flutter pub get
flutter analyze
flutter test
flutter build web --release

firebase deploy --only hosting --project $ExpectedProject

Write-Host "Done. https://sotong-finance.web.app"
