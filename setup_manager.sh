#!/bin/bash
# Docker Swarm 매니저 노드 초기화
# by 채티 for 치님

set -e

MANAGER_IP=$(hostname -I | awk '{print $1}')
echo "🧭 Swarm 초기화 중... (IP: $MANAGER_IP)"
docker swarm init --advertise-addr $MANAGER_IP

echo "🔑 Worker 노드가 참여할 수 있는 명령:"
docker swarm join-token worker
