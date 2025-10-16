#!/bin/bash
set -e

echo "=== Swarm Monitoring Deployment ==="

# 1️⃣ 환경 변수 입력
read -p "매니저 노드 호스트명: " MANAGER
read -p "워커 노드 1 호스트명: " WORKER1
read -p "워커 노드 2 호스트명: " WORKER2
read -p "워커 노드 3 호스트명: " WORKER3

# Prometheus 설정 파일 자동 업데이트
cat > prometheus/prometheus.yml <<EOL
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'docker'
    static_configs:
      - targets: ['$MANAGER:9323','$WORKER1:9323','$WORKER2:9323','$WORKER3:9323']
EOL

echo "✅ prometheus.yml 업데이트 완료"

# 2️⃣ Swarm 스택 배포
docker stack deploy -c docker-compose.yml monitoring
echo "✅ Swarm Monitoring Stack 배포 완료"

echo "Prometheus: http://$MANAGER:9090"
echo "Grafana: http://$MANAGER:3000 (ID/Password: admin/admin)"
