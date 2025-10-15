#!/bin/bash
# Docker Swarm 워커 노드 참여 스크립트 (수동 입력 버전)
# by 채티 for 치님

set -e

echo "🔹 매니저 노드 IP와 포트를 입력하세요 (예: 192.168.0.3:2377):"
read MANAGER_IP

echo "🔹 매니저에서 발급받은 워커 토큰을 입력하세요:"
read JOIN_TOKEN

echo "🔗 매니저 노드($MANAGER_IP)에 Swarm 참여 중..."
docker swarm join --token $JOIN_TOKEN $MANAGER_IP

echo "✅ 워커 노드 Swarm 참여 완료!"
