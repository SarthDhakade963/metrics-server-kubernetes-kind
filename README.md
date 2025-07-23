# 📊 Deploying Metrics Server in KIND

This guide helps you deploy the latest [`metrics-server`](https://github.com/kubernetes-sigs/metrics-server) in a **KIND** cluster and enable resource monitoring using `kubectl top`.

---

## 🚀 Step 1: Deploy the Latest Metrics Server

Apply the latest release (v0.5.0):

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.0/components.yaml
```

## 🔧 Step 2: Patch for KIND Compatibility
KIND requires insecure TLS communication with the kubelet. Patch the deployment to add this flag:

```bash
kubectl patch deployment metrics-server -n kube-system --type=json \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tl
```

## ✅ Step 3: Verify Deployment
Check if the metrics-server pod is running in the kube-system namespace:

```bash
kubectl get pods -n kube-system
```
Look for a pod named metrics-server. If it's running, the deployment is successful.


## 📈 Step 4: View Resource Metrics
View Node Resource Usage:

```bash
kubectl top nodes
```
View Pod Resource Usage in a Namespace (e.g., nginx):
```bash
kubectl top pods -n nginx
```

## 🧠 Notes 
  * Ensure the cluster is running and all nodes are in the Ready state before deploying metrics-server.
  * This setup is tailored for local development using KIND.


## 🔗 References

- [Metrics Server GitHub Repository](https://github.com/kubernetes-sigs/metrics-server)

- [KIND (Kubernetes IN Docker)](https://kind.sigs.k8s.io/)

- [Sample Setup Gist by sanketsudake](https://gist.github.com/sanketsudake/a089e691286bf2189bfedf295222bd43)
