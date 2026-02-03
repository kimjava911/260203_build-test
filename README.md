# Build and Deploy Web Image

이 프로젝트는 간단한 웹 페이지를 포함하는 Docker 이미지를 빌드하여 GitHub Container Registry(GHCR) 및 Amazon Elastic Container Registry(ECR)에 배포하는 예제입니다.

## 프로젝트 구조

```
.
├── .github/workflows/
│   ├── 01_ghcr.yml   # GHCR 배포 워크플로우
│   └── 02_ecr.yml    # ECR 배포 워크플로우
├── Dockerfile        # Nginx 기반 Docker 이미지 설정
└── index.html        # 웹 서버에서 제공할 기본 페이지
```

## Docker 이미지 실행 및 테스트 방법

이 프로젝트의 Docker 이미지는 로컬에서 직접 빌드하거나, GHCR 또는 ECR에서 가져와 실행할 수 있습니다.

### 1. 로컬에서 직접 빌드하고 실행하기

Docker만 설치되어 있으면, 원격 레지스트리를 사용하지 않고 로컬에서 이미지를 빌드하고 실행할 수 있습니다.

#### 1.1. Docker 이미지 빌드

`Dockerfile`이 있는 프로젝트 루트 디렉토리에서 아래 명령어를 실행하여 Docker 이미지를 빌드합니다.

```bash
docker build -t my-web-app:latest .
```

#### 1.2. Docker 컨테이너 실행

빌드된 이미지를 사용하여 Docker 컨테이너를 실행합니다. 컨테이너의 80번 포트를 로컬의 8080 포트와 매핑합니다.

```bash
docker run -d -p 8080:80 --name my-nginx-app my-web-app:latest
```

#### 1.3. 테스트

`curl` 명령어나 웹 브라우저를 사용하여 `http://localhost:8080`에 접속하여 웹 페이지가 정상적으로 표시되는지 확인합니다.

```bash
curl http://localhost:8080
```

#### 1.4. 컨테이너 중지 및 삭제

테스트가 완료되면 컨테이너를 중지하고 삭제합니다.

```bash
docker stop my-nginx-app
docker rm my-nginx-app
```

### 2. GHCR에서 이미지 가져와서 테스트하기

#### 2.1. Docker 이미지 PULL

GHCR에서 이미지를 가져옵니다. `<github_username>`과 `<repository_name>`을 실제 값으로 바꿔주세요.

```bash
docker pull ghcr.io/<github_username>/<repository_name>:latest
```

#### 2.2. Docker 컨테이너 실행

```bash
docker run -d -p 8080:80 --name my-nginx-app ghcr.io/<github_username>/<repository_name>:latest
```

#### 2.3. 테스트

`curl` 명령어나 웹 브라우저를 사용하여 `http://localhost:8080`에 접속합니다.

```bash
curl http://localhost:8080
```

#### 2.4. 컨테이너 중지 및 삭제

```bash
docker stop my-nginx-app
docker rm my-nginx-app
```

### 3. Amazon ECR에서 이미지 가져와서 테스트하기

ECR에서 이미지를 가져오려면 AWS CLI가 설치 및 구성되어 있어야 합니다.

#### 3.1. ECR 로그인

AWS CLI를 사용하여 ECR에 로그인합니다. `<aws_account_id>`를 실제 AWS 계정 ID로 바꿔주세요.

```bash
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.ap-northeast-2.amazonaws.com
```

#### 3.2. Docker 이미지 PULL

ECR에서 이미지를 가져옵니다. `<aws_account_id>`와 `<repository_name>`을 실제 값으로 바꿔주세요.

```bash
docker pull <aws_account_id>.dkr.ecr.ap-northeast-2.amazonaws.com/<repository_name>:latest
```

#### 3.3. Docker 컨테이너 실행

가져온 이미지를 사용하여 Docker 컨테이너를 실행합니다. 컨테이너의 80번 포트를 로컬의 8080 포트와 매핑합니다.

```bash
docker run -d -p 8080:80 --name my-nginx-app <aws_account_id>.dkr.ecr.ap-northeast-2.amazonaws.com/<repository_name>:latest
```

#### 3.4. 테스트

`curl` 명령어나 웹 브라우저를 사용하여 `http://localhost:8080`에 접속하여 웹 페이지가 정상적으로 표시되는지 확인합니다.

```bash
curl http://localhost:8080
```

#### 3.5. 컨테이너 중지 및 삭제

테스트가 완료되면 컨테이너를 중지하고 삭제합니다.

```bash
docker stop my-nginx-app
docker rm my-nginx-app
```
