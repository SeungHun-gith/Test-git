# Supabase에 추천 번호 저장하기 – 테이블 설정

## 1. Supabase 대시보드에서 테이블 만들기

1. [Supabase](https://supabase.com) 로그인 → 프로젝트 선택
2. 왼쪽 메뉴 **SQL Editor** 클릭
3. **New query** 선택 후 아래 SQL 전체 복사해서 붙여넣기
4. **Run** (또는 Ctrl+Enter) 실행

```sql
-- 로또 추천 번호 저장 테이블
CREATE TABLE IF NOT EXISTS lotto_recommendations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  main_numbers JSONB NOT NULL,   -- [1, 5, 12, 23, 33, 40] 형태
  bonus_number INT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 인덱스: 최신순 조회용
CREATE INDEX IF NOT EXISTS idx_lotto_recommendations_created_at
  ON lotto_recommendations (created_at DESC);

-- 누구나 INSERT 가능 (웹에서 번호 뽑을 때 저장용)
ALTER TABLE lotto_recommendations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow anonymous insert"
  ON lotto_recommendations FOR INSERT
  TO anon
  WITH CHECK (true);

-- 누구나 최근 데이터 조회 가능 (선택 사항)
CREATE POLICY "Allow public read"
  ON lotto_recommendations FOR SELECT
  TO anon
  USING (true);
```

실행이 끝나면 **Table Editor**에서 `lotto_recommendations` 테이블이 보입니다.

---

## 2. API 키 확인

1. 왼쪽 **Project Settings** (톱니바퀴) → **API**
2. 아래 값 확인:
   - **Project URL**: `https://xxxxx.supabase.co`
   - **anon public** 키: `eyJhbGciOiJIUzI1NiIsInR5cCI6...` (긴 문자열)

이 두 값을 `index.html` 안의 Supabase 설정에 넣어야 합니다.

---

## 3. Supabase 연결 설정

**Vercel로 배포한 경우**  
코드에 키를 넣지 말고, **Vercel 환경 변수**만 설정하면 됩니다.  
→ 자세한 방법은 **`VERCEL_환경변수_설정.md`** 참고.

**로컬에서만 쓸 때**  
`index.html` 안의 Supabase 설정은 이제 `/api/config`에서 불러오므로, 로컬에서 API가 없다면 Supabase 저장은 동작하지 않습니다. 로컬에서도 테스트하려면 `vercel dev`로 실행하거나, 임시로 스크립트에 URL/KEY를 넣어 사용할 수 있습니다.

저장 후 페이지에서 번호를 뽑으면 Supabase `lotto_recommendations` 테이블에 자동으로 저장됩니다.
