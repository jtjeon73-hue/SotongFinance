# 개인정보·프라이버시 검토 (3단계)

관련: [privacy-security-guide.md](privacy-security-guide.md) · [deployment-guide.md](deployment-guide.md) · [content-roadmap.md](content-roadmap.md)

Firebase 프로젝트는 **`sotong-finance`** 만 사용합니다.  
원칙: **개인 재무 입력을 서버에 저장하지 않음.**

## 범위

계산기·재무진단·IPS 워크시트·체크리스트에 사용자가 넣는 금액·소득·부채·보유 정보 등.

## 금지 (필수)

| 항목 | 요구 |
|------|------|
| Firestore / Realtime DB / Storage | 재무 입력값 **저장 금지** |
| Analytics / 측정 | 재무 입력값·자유텍스트를 이벤트 파라미터로 **전송 금지** |
| URL 쿼리 | 금액·소득 등 입력을 `?amount=` 형태로 **넣지 않음** (공유·로그 유출) |
| 클립보드 | **사용자가 시작한** 복사만 허용. 자동·백그라운드 클립보드 읽기/쓰기 금지 |
| 로그 | 서버·CI 로그에 입력 원문 남기지 않음 |

1단계 [privacy-security-guide.md](privacy-security-guide.md)의 주민번호·계좌·비밀번호·실보유종목 등 금지도 동일하게 유지합니다.

## 허용 (로컬)

- 브라우저 메모리(세션)에서만 계산·표시  
- 사용자가 직접 저장·인쇄·복사한 결과물(기기 로컬)  
- 콘텐츠·출처 메타데이터 등 **비개인** 정적 데이터

“저장됨” UI는 **실제 서버 저장이 있을 때만** 사용합니다. 없으면 표시하지 않습니다.

## 향후 개인 재무기록

로그인·암호화·권한·개인정보처리방침·영향평가를 **별도 통과한 뒤에만** 검토 ([content-roadmap.md](content-roadmap.md) 3단계 항목).  
본 문서 기준이 완화되기 전까지는 서버 저장을 도입하지 않습니다.

## 검수 체크

- [ ] 재무 입력 → Firestore/Analytics 경로 없음  
- [ ] 라우트·공유 링크에 입력값 쿼리 없음  
- [ ] 클립보드 = 사용자 제스처만  
- [ ] Hosting만 사용 시에도 동일 원칙  
- [ ] Firebase 프로젝트가 `sotong-finance`인지 확인
