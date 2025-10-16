#!/bin/bash
set -e

echo "=== Swarm Monitoring Full Auto Deployment ==="

# 1️⃣ 환경 변수 입력
read -p "매니저 노드 호스트명/IP: " MANAGER
read -p "워커 노드 1 호스트명/IP: " WORKER1
read -p "워커 노드 2 호스트명/IP: " WORKER2
read -p "워커 노드 3 호스트명/IP: " WORKER3

NODES=("$MANAGER" "$WORKER1" "$WORKER2" "$WORKER3")

# 2️⃣ Prometheus scrape_targets 자동 생성
TARGETS=""
for NODE in "${NODES[@]}"; do
  TARGETS="$TARGETS'$NODE:9323',"
done
TARGETS=${TARGETS%,}  # 마지막 콤마 제거

cat > prometheus/prometheus.yml <<EOL
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'docker'
    static_configs:
      - targets: [$TARGETS]
EOL

echo "✅ prometheus.yml 업데이트 완료"

# 3️⃣ Swarm 스택 배포
docker stack deploy -c docker-compose.yml monitoring
echo "✅ Swarm Monitoring Stack 배포 완료"

echo "Prometheus: http://$MANAGER:9090"
echo "Grafana: http://$MANAGER:3000 (ID/Password: admin/admin)"
