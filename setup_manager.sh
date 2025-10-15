#!/bin/bash
# Docker Swarm 매니저 노드 초기화 (GitHub 자동화 버전)
# by 채티 for 치님

set -e

MANAGER_IP=$(hostname -I | awk '{print $1}')
echo "🧭 Swarm 초기화 중... (IP: $MANAGER_IP)"
docker swarm init --advertise-addr $MANAGER_IP

# 토큰을 파일로 저장 (워커 노드에서 자동 참조)
docker swarm join-token worker -q > manager_info.txt

echo "🔑 워커 노드가 참조할 파일 manager_info.txt 생성 완료"
echo "📄 토큰 확인: cat manager_info.txt"
