#!/bin/bash
# Docker Swarm 워커 노드 참여 스크립트
# by 채티 for 치님

# 매니저 노드에서 출력된 토큰과 IP를 아래 변수에 입력하세요
MANAGER_IP="192.168.0.10"
JOIN_TOKEN="SWMTKN-1-xxxxx-xxxxx"

echo "🔗 매니저 노드($MANAGER_IP)에 Swarm 참여 중..."
docker swarm join --token $JOIN_TOKEN $MANAGER_IP:2377
echo "✅ 워커 노드로 성공적으로 연결되었습니다."
