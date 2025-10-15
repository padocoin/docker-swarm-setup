#!/bin/bash
# Ubuntu 서버용 Docker 엔진 및 권한 설정 자동화
# by 채티 for 치님

set -e

echo "📦 시스템 업데이트 중..."
sudo apt update -y && sudo apt upgrade -y

echo "🔧 필수 패키지 설치 중..."
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "🔑 Docker GPG 키 및 저장소 추가 중..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg]   https://download.docker.com/linux/ubuntu   $(lsb_release -cs) stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🐳 Docker 엔진 설치 중..."
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "👥 사용자 권한 설정 중..."
sudo usermod -aG docker $USER

echo "🔁 Docker 서비스 자동 시작 설정..."
sudo systemctl enable docker
sudo systemctl start docker

echo "✅ Docker 설치 및 권한 설정 완료!"
echo "➡️ 로그아웃 후 다시 로그인하면 sudo 없이 docker 명령어 사용 가능."
