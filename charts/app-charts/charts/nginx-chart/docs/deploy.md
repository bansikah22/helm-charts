### create self signed certificate
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls/tls.key -out tls/tls.crt -subj "/CN=noelbansikah.com"
```

#### dev environment
```bash
kubectl create namespace dev
helm install portfolio-dev . -f values-dev.yaml -n dev
helm uninstall portfolio-dev -n dev
```

### Staging Environment
```bash
kubectl create namespace staging
helm install nginx-staging . -f values-staging.yaml -n staging
```

#### production environment
```bash
kubectl create namespace prod
helm install portfolio-prod . -f values-prod.yaml -n prod
helm uninstall portfolio-prod -n prod
```

#### verify deployments
```bash
kubectl get all -n dev
kubectl get all -n prod
kubectl get ingress -n dev
kubectl get ingress -n prod
kubectl get secret -n prod
```

#### Minikube configuration
```bash
minikube addons enable ingress
echo "$(minikube ip) noelbansikah.local" | sudo tee -a /etc/hosts
echo "$(minikube ip) noelbansikah.com" | sudo tee -a /etc/hosts
```