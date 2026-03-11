-- ============================================================
-- 로또 추천 번호 저장용 Supabase 테이블
-- Supabase 대시보드 → SQL Editor 에서 이 파일 내용 붙여넣고 Run
-- ============================================================

-- 테이블: 로또 추천 번호 (main 6개 + bonus 1개)
CREATE TABLE IF NOT EXISTS lotto_recommendations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  main_numbers JSONB NOT NULL,   -- [1, 5, 12, 23, 33, 40] 형태
  bonus_number INT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 인덱스: 최신순 조회용
CREATE INDEX IF NOT EXISTS idx_lotto_recommendations_created_at
  ON lotto_recommendations (created_at DESC);

-- RLS 활성화
ALTER TABLE lotto_recommendations ENABLE ROW LEVEL SECURITY;

-- 정책: 익명 사용자도 INSERT 가능 (웹에서 번호 뽑을 때 저장)
CREATE POLICY "Allow anonymous insert"
  ON lotto_recommendations FOR INSERT
  TO anon
  WITH CHECK (true);

-- 정책: 누구나 SELECT 가능 (최근 추천 목록 조회용)
CREATE POLICY "Allow public read"
  ON lotto_recommendations FOR SELECT
  TO anon
  USING (true);

-- ============================================================
-- (참고) 테이블 삭제가 필요할 때만 아래 주석 해제 후 실행
-- ============================================================
-- DROP POLICY IF EXISTS "Allow public read" ON lotto_recommendations;
-- DROP POLICY IF EXISTS "Allow anonymous insert" ON lotto_recommendations;
-- DROP TABLE IF EXISTS lotto_recommendations;
