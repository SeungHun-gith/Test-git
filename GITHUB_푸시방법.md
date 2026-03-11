# GitHub 연동 및 푸시 방법

## ✅ 완료된 작업
- Git 저장소 초기화
- `index.html` 첫 커밋 완료
- 브랜치 이름: `main`

## 📌 직접 하실 작업

### 1. GitHub에서 새 저장소 만들기
1. https://github.com 접속 후 로그인
2. 오른쪽 상단 **+** → **New repository** 클릭
3. **Repository name**: 원하는 이름 입력 (예: `20260311` 또는 `my-project`)
4. **Public** 선택
5. **"Add a README file"** 체크 해제 (이미 로컬에 커밋이 있음)
6. **Create repository** 클릭

### 2. 생성된 저장소 URL 확인
저장소 생성 후 나오는 주소를 복사합니다.
- HTTPS: `https://github.com/내아이디/저장소이름.git`
- SSH: `git@github.com:내아이디/저장소이름.git`

### 3. 터미널에서 원격 추가 및 푸시
이 폴더에서 PowerShell 또는 명령 프롬프트를 열고:

```powershell
cd "c:\Users\SD2-25\Downloads\20260311"

# 아래 URL을 본인 GitHub 저장소 주소로 바꾸세요
git remote add origin https://github.com/내아이디/저장소이름.git

git push -u origin main
```

### 4. 로그인 안내
처음 푸시 시 GitHub 로그인 창이 뜨거나, 비밀번호 대신 **Personal Access Token** 입력을 요구할 수 있습니다.
- 토큰 발급: GitHub → Settings → Developer settings → Personal access tokens
- 권한: `repo` 체크 후 토큰 생성 후 비밀번호 대신 입력

---

한 번 원격을 추가하고 푸시하면, 이후에는 `git push` 만 입력하면 됩니다.
