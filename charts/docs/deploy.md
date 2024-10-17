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

## Deploying nginx-app
```bash
echo "$(minikube ip) nginx-app.local" | sudo tee -a /etc/hosts
```


## Deploy random group generator flask app
```bash
helm upgrade --install traefik traefik/traefik -f values.yaml -n kube-system
helm install random-group-generator ./random-group-generator-chart
## edit /etc/hosts file
127.0.0.1 random-group-generator.local
helm upgrade random-group-generator ./random-group-generator-chart
## debuging
kubectl delete svc -n kube-system traefik
helm upgrade --install traefik traefik/traefik -n kube-system --set service.type=LoadBalancer
kubectl get svc -n kube-system traefik
```

## deploying random group generator
```bash
minikube start
### install traefik
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
helm install traefik traefik/traefik --namespace kube-system --create-namespace --set service.type=NodePort --set dashboard.enabled=true --set dashboard.domain=traefik.local

### deploy application
helm install random-group-generator ./charts/random-group-generator --namespace default --create-namespace

## edit /etc/hosts
192.168.49.2 random-group-generator.local # Replace with your Minikube IP.
192.168.49.2 traefik.local               # Replace with your Minikube IP.

## test application
curl http://random-group-generator.local/

## monitor
kubectl logs -l app=random-group-generator -n default 

```
