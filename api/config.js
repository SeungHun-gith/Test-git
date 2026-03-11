/**
 * Vercel Serverless Function
 * 환경 변수 SUPABASE_URL, SUPABASE_ANON_KEY 를 클라이언트에 전달합니다.
 * (anon key는 클라이언트 공개용이므로 이 방식이 안전합니다.)
 */
export default {
  fetch(request) {
    const body = {
      SUPABASE_URL: process.env.SUPABASE_URL || '',
      SUPABASE_ANON_KEY: process.env.SUPABASE_ANON_KEY || '',
    };
    return new Response(JSON.stringify(body), {
      status: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    });
  },
};
