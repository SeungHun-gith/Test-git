# Vercel 환경 변수로 Supabase 연동하기

이 프로젝트는 **Vercel 환경 변수**에서 Supabase URL과 anon key를 읽어 사용합니다.  
코드에 키를 넣지 않아도 되고, Vercel 대시보드에서만 관리하면 됩니다.

---

## 1. Vercel에 환경 변수 추가

1. [Vercel Dashboard](https://vercel.com/dashboard) 접속 후 해당 프로젝트 선택
2. 상단 **Settings** 탭 클릭
3. 왼쪽 메뉴에서 **Environment Variables** 선택
4. 아래 두 개 변수 추가:

| Name | Value | 적용 환경 |
|------|--------|-----------|
| `SUPABASE_URL` | `https://여기프로젝트ID.supabase.co` | Production, Preview, Development 모두 체크 |
| `SUPABASE_ANON_KEY` | Supabase anon public 키 (긴 문자열) | Production, Preview, Development 모두 체크 |

- **SUPABASE_URL**: Supabase 프로젝트 → **Project Settings** → **API** → Project URL
- **SUPABASE_ANON_KEY**: 같은 화면에서 **Project API keys** → `anon` `public` 키 복사

5. **Save** 클릭

---

## 2. 동작 방식

- 프론트엔드(`index.html`)는 페이지 로드 시 **`/api/config`** 를 호출합니다.
- Vercel 서버리스 함수 `api/config.js`가 `SUPABASE_URL`, `SUPABASE_ANON_KEY`를 읽어 JSON으로 내려줍니다.
- 클라이언트는 이 값으로 Supabase 클라이언트를 만들고, 추천 번호 저장 시 이 클라이언트를 사용합니다.

환경 변수를 수정한 뒤에는 **재배포**(Redeploy) 한 번 해주면 반영됩니다.

---

## 3. 로컬에서 테스트할 때

로컬에서 `vercel dev` 를 쓰면 같은 환경 변수가 적용됩니다.

- 터미널에서 프로젝트 폴더로 이동 후 `vercel dev` 실행
- `.env.local` 파일에 아래처럼 넣어 두면 로컬에서도 사용 가능:

```
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6...
```

(Vercel CLI로 연결된 프로젝트는 Dashboard에 설정한 값이 로컬에도 동기화될 수 있습니다.)
