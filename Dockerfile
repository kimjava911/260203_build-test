# 기본 이미지로 공식 Nginx (alpine 버전) 이미지를 사용합니다.
FROM nginx:alpine

# 로컬의 index.html 파일을 컨테이너의 Nginx 웹 서버 루트 디렉토리로 복사합니다.
COPY index.html /usr/share/nginx/html
