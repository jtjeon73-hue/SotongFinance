# 전문가 금융 콘텐츠 작성 표준 (3단계)

관련: [finance-content-standard.md](finance-content-standard.md) · [practical-finance-standard.md](practical-finance-standard.md) · [content-quality-report.md](content-quality-report.md) · [cd-content-analysis.json](cd-content-analysis.json)

2단계 실무 골격을 유지하고, **콘텐츠 유형(kind)별 품질 기준**으로 C/D를 A/B로 올립니다.  
원칙 유지: 상품 추천 없음 · 허위·고정 금리/세율 없음 · 개인재무 서버 비저장 · Firebase `sotong-finance`만.

## 유형 판정

분석 스냅샷은 `tool/cd_analysis.dart` → [cd-content-analysis.json](cd-content-analysis.json).  
`inferredKind`와 `contentType`을 함께 보고, 아래 표의 **필수 섹션**을 채웁니다.

| 유형 | 대표 | A/B 핵심 |
|------|------|----------|
| 개념 | concept / risk / econ | 정의·오해·숫자 확인 축·한계 |
| 절차 | actionGuide / review | ①②③ 순서·증빙·실패 지점 |
| 비교 | vs / buy-rent 등 | 비교 축 표·개인차·단정 금지 |
| 체크리스트 | checklist | 실행 가능 항목·주기·후속 |
| 사례 | scenario | 가정 명시·대안·일반화 한계 |
| 세금·제도 | tax / pension 제도 | 준비 흐름·공식 확인·세액 비확정 |
| 용어 | glossary | 정확한 정의·관련어·오용 주의 (**B 허용**) |
| 사기예방 | fraud-* | 신호·대응·신고 경로·공포 과장 금지 |

## 공통 필수 (2단계 +α)

| 섹션 | 역할 |
|------|------|
| 쉬운 설명 | 한두 문장, 오해 방지 |
| 유형별 핵심 블록 | 위 표 |
| 위험·한계 | 최악·개인차·적용 범위 |
| 체크리스트 또는 질문 목록 | 인쇄·복사 가능 |
| 공식 확인·기준일 | `referenceYear`, `checkedAt`, `reviewDueAt`, `sourceIds` |
| 교육용·개인정보 고지 | 추천 금지, 서버 비저장 |

## 유형별 추가 필수

### 개념
- 확인할 숫자·계산 흐름(허위 고정값 금지)
- “이 개념으로 **할 수 없는 것**” 한 줄

### 절차
- 단계별 입력물·산출물
- 막히면 어디로(공식·전문가 플래그)

### 비교
- 최소 3개 비교 축 (비용·위험·유동성·세금·기간 등)
- “누구에게 유리한가”를 **조건**으로만 서술

### 체크리스트
- 항목마다 확인 출처·주기
- 완료 후 `nextActions` 1~3개

### 사례
- 가정(소득·부채·기간)을 표로
- 다른 가정이면 결론이 바뀌는 포인트

### 세금·제도
- 준비자료·기한·관할만 (세액 확정 금지)
- `professionalReviewRequired` / `officialCalculatorRecommended` / `versionDependent`

### 용어 (glossary)
- 정의 정확·관련 ID 연결이면 **B 등급으로 충분** (무리한 A 패딩 금지)
- 키워드 나열·동의어 도배로 길이 늘 않기

### 사기예방
- 구체 신호 → 즉시 행동 → 공식·상담 경로
- “무조건 당한다/절대 안전” 식 과장 금지

## 금지·품질 함정

- **키워드 스터핑**: 검색어·동의어를 본문에 반복 삽입하지 않음
- 고정 자산배분·만인 SWR·상품 가입 권유
- 세율·보호한도·LTV/DSR을 앱에 영구 고정
- 민감 재무정보를 서버·Analytics·URL에 실음 → [privacy-review.md](privacy-review.md)

## 등급 메모 (3단계)

- **A**: 유형 필수 충족 + 절차/위험/체크리스트/출처 (의사결정 전 점검 가능)
- **B**: 기본 학습 충분. **정확한 용어집·짧은 개념은 B가 정상**
- **C/D**: [cd-content-analysis.json](cd-content-analysis.json) 우선순위로 보강

상세 집계는 [content-quality-report.md](content-quality-report.md) (보강 후 A/B/C/D 갱신).

## 검수 체크

- [ ] 유형 판정·유형별 필수 섹션
- [ ] 추천·보장·고정 비율/인출률 없음
- [ ] 키워드 스터핑 없음
- [ ] glossary는 정확성 우선, 불필요 A 강요 없음
- [ ] `reviewDueAt`·출처·개인정보 고지
