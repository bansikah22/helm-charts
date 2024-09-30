## Helm Charts Deployment for multiple charts

```bash
minikube start --nodes 2
kubectl get nodes
kubectl get pods -o wide
kubectl get ingress
##Adding extra nodes
minikube node add
kubectl get nodes
## Labeling nodes
kubectl label nodes minikube-m02 role=worker
kubectl get nodes --show-labels
kubectl label nodes minikube-m02 app=my-app
helm install shop-app-dev --namespace dev ./app-charts/charts/shop-app --values ./app-charts/charts/shop-app/values-dev.yaml
##Debuging
ping shop-app-dev.local
nslookup shop-app-dev.local
helm uninstall shop-app-dev -n dev
minikube addons enable ingress ## Always enable when using ingress with nginx
```

## Deploying user-app
```bash
helm uninstall user-app-dev -n dev
kubectl get nodes --show-labels
helm install user-app-dev --namespace dev ./app-charts/charts/user-app --values ./app-charts/charts/user-app/values-dev.yaml
kubectl get svc -n dev
kubectl get pods -n dev

```

