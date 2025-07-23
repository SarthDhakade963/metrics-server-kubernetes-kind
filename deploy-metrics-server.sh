#!/bin/bash

# ============================================================
# 🔧 Usage:
# Save this file as deploy-metrics-server.sh
#
# Make it executable:
#   chmod +x deploy-metrics-server.sh
#
# Run it:
#   ./deploy-metrics-server.sh
# ============================================================

# Deploy Metrics Server in KIND
set -e

echo "🚀 Step 1: Applying latest metrics-server release..."
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.0/components.yaml

echo "⏳ Waiting for metrics-server deployment to appear..."
kubectl rollout status deployment metrics-server -n kube-system

echo "🔧 Step 2: Patching metrics-server with --kubelet-insecure-tls..."
kubectl patch deployment metrics-server -n kube-system --type=json \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'

echo "⏳ Waiting for rollout to complete after patching..."
kubectl rollout status deployment metrics-server -n kube-system

echo "✅ Step 3: Verifying metrics-server pod..."
kubectl get pods -n kube-system | grep metrics-server

echo "📈 Step 4: Sample Metrics Commands"
echo "  → Node metrics:"
echo "    kubectl top nodes"
echo ""
echo "  → Pod metrics in a namespace (e.g., nginx):"
echo "    kubectl top pods -n nginx"

echo "🎉 Metrics Server successfully deployed in KIND!"
