# 로또 번호 추천 페이지 → Supabase에 올리는 방법

현재 프로젝트는 **index.html** 한 개의 정적 페이지라서, **Supabase Storage**에 올려서 공개 URL로 접속할 수 있게 할 수 있습니다.

---

## 1. Supabase 프로젝트 만들기

1. **https://supabase.com** 접속 후 로그인(또는 회원가입)
2. **New project** 클릭
3. **Organization** 선택 (없으면 새로 생성)
4. **Name**: 예) `lotto-app`
5. **Database Password**: 비밀번호 설정 후 기억해 두기
6. **Region**: `Northeast Asia (Seoul)` 선택 권장
7. **Create new project** 클릭 → 생성 완료될 때까지 대기

---

## 2. Storage 버킷 만들기

1. 왼쪽 메뉴에서 **Storage** 클릭
2. **New bucket** 클릭
3. **Name**: `lotto` (또는 원하는 이름, 영문 소문자)
4. **Public bucket** 체크 (웹에서 바로 접속하려면 필수)
5. **Create bucket** 클릭

---

## 3. index.html 업로드

1. 방금 만든 버킷 이름 클릭 (예: `lotto`)
2. **Upload file** 또는 **Upload** 버튼 클릭
3. **index.html** 파일 선택 후 업로드
   - 경로: `c:\Users\SD2-25\Downloads\20260311\index.html`

업로드가 끝나면 파일 목록에 `index.html`이 보입니다.

---

## 4. 공개 URL로 접속하기

Supabase Storage의 공개 URL 형식은 다음과 같습니다.

```
https://[프로젝트ID].supabase.co/storage/v1/object/public/[버킷이름]/index.html
```

- **프로젝트 ID**: Supabase 대시보드 왼쪽 아래 **Project Settings** → **General** 에서 **Reference ID** 확인
- **버킷 이름**: 2번에서 만든 이름 (예: `lotto`)

예시:
```
https://abcdefghijk.supabase.co/storage/v1/object/public/lotto/index.html
```

이 주소를 브라우저에 넣으면 로또 추천 페이지가 열립니다.  
이 URL을 그대로 공유하면 다른 사람도 접속할 수 있습니다.

---

## 5. (선택) 메인 주소를 짧게 쓰고 싶을 때

- **index.html**만 올렸다면 위 URL 끝에 `/index.html`까지 넣어야 합니다.
- 나중에 **커스텀 도메인**을 쓰거나, **Vercel / Netlify** 같은 서비스에 똑같은 파일을 배포하면 `https://내도메인.com` 처럼 짧은 주소로도 사용할 수 있습니다. Supabase만 쓸 때는 위 공개 URL이 기본 주소입니다.

---

## 요약 체크리스트

| 단계 | 할 일 |
|------|--------|
| 1 | Supabase에서 새 프로젝트 생성 |
| 2 | Storage에서 **Public** 버킷 생성 (이름 예: lotto) |
| 3 | 해당 버킷에 **index.html** 업로드 |
| 4 | `https://[프로젝트ID].supabase.co/storage/v1/object/public/[버킷이름]/index.html` 로 접속 |

수정한 뒤 다시 올리려면, Storage에서 기존 **index.html**을 삭제하고 새 **index.html**을 같은 버킷에 다시 업로드하면 됩니다.
