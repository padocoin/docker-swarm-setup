#!/bin/bash
set -e

echo "🔹 Docker 설치 시작"

# 기존 설치 제거
sudo apt remove -y docker docker-engine docker.io containerd runc

# 필수 패키지 설치
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

# Docker GPG 키 및 저장소 등록
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker 설치
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 사용자 권한 추가
sudo usermod -aG docker $USER

# 서비스 활성화 및 시작
sudo systemctl enable docker
sudo systemctl start docker

echo "✅ Docker 설치 완료"
docker --version
