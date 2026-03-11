# 추천 번호가 DB에 안 들어갈 때 점검 사항

## 1. 브라우저 개발자 도구로 확인

1. 배포된 사이트에서 **F12** (또는 우클릭 → 검사) → **Console** 탭 열기  
2. 페이지 새로고침 후 **한 판 뽑기** 클릭  
3. 콘솔에 `[Supabase]` 로 시작하는 메시지가 있는지 확인  

| 메시지 | 의미 | 조치 |
|--------|------|------|
| `Vercel에 SUPABASE_URL, SUPABASE_ANON_KEY 환경 변수를 설정해 주세요.` | API가 빈 값을 반환함 | Vercel 환경 변수 설정 후 **재배포** |
| `config 로드 실패` | `/api/config` 요청 실패 (CORS/네트워크 등) | 같은 도메인에서 열었는지, Vercel 배포 주소인지 확인 |
| `저장 실패: ...` | Supabase가 에러 반환 (RLS, 테이블 없음 등) | 아래 2·3번 확인 |
| (아무 메시지 없음) | 저장 성공이거나 supabase 미연결 | 2·3번 확인 |

---

## 2. Vercel 환경 변수 확인

1. [Vercel Dashboard](https://vercel.com/dashboard) → 해당 프로젝트 → **Settings** → **Environment Variables**  
2. 아래 두 개가 **모두** 있는지 확인  
   - `SUPABASE_URL` = `https://xxxxx.supabase.co` (끝에 슬래시 없음)  
   - `SUPABASE_ANON_KEY` = `eyJ...` 로 시작하는 긴 문자열  
3. **수정했다면 반드시 재배포**  
   - **Deployments** 탭 → 최신 배포 오른쪽 **⋮** → **Redeploy**  

---

## 3. Supabase 테이블·RLS 확인

1. [Supabase](https://supabase.com) → 해당 프로젝트 → **Table Editor**  
2. **lotto_recommendations** 테이블이 있는지 확인  
   - 없으면 **SQL Editor**에서 `supabase_schema.sql` 내용 실행  
3. **Authentication** → **Policies** (또는 Table Editor에서 테이블 클릭 → RLS)  
   - `lotto_recommendations` 테이블에 **Allow anonymous insert** 정책이 있어야 함  
   - 없으면 `supabase_schema.sql` 안의 `CREATE POLICY "Allow anonymous insert"` 부분만 다시 실행  

---

## 4. 코드 변경 사항 (이미 반영됨)

- **초기화 대기**: 저장 전에 `/api/config` 로딩이 끝날 때까지 기다리도록 수정했습니다.  
- **에러 로그**: 저장 실패 시 콘솔에 `[Supabase] 저장 실패: ...` 가 뜨도록 했습니다.  

위 단계를 순서대로 확인한 뒤, 콘솔에 찍힌 메시지를 보면 원인을 좁힐 수 있습니다.
