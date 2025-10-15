#!/bin/bash
# Docker Swarm 워커 노드 참여 스크립트 (GitHub 자동화 버전)
# by 채티 for 치님

# GitHub Repository 경로
GIT_REPO="https://github.com/padocoin/docker-swarm-setup.git"

# 클론 & 이동
git clone $GIT_REPO swarm-setup-temp
cd swarm-setup-temp

# 매니저 정보 읽기 (manager_info.txt)
if [ ! -f manager_info.txt ]; then
    echo "❌ manager_info.txt 파일을 찾을 수 없습니다. 매니저 노드에서 생성해야 합니다."
    exit 1
fi

MANAGER_IP=$(hostname -I | awk '{print $1}') # 현재 워커 IP 확인 (필요시 수정 가능)
JOIN_TOKEN=$(cat manager_info.txt)

echo "🔗 매니저 노드에 Swarm 참여 중..."
docker swarm join --token $JOIN_TOKEN $MANAGER_IP:2377 || echo "⚠️ IP/토큰 확인 필요"

echo "✅ 워커 노드 Swarm 참여 완료"
