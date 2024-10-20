### Add the Jetstack Helm repository
```bash
helm repo add jetstack https://charts.jetstack.io
helm repo update
### create namespace 
kubectl create namespace cert-manager
### Verify that ClusterIssuer was created successfully
kubectl get clusterissuer -n cert-manager
##Get pods under cert-manager namespace
kubectl get pods -n cert-manager
```
### Install cert manager
```bash
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager --create-namespace \
  --version v1.11.0 \
  --set installCRDs=true
```

### Create a cluster issuer
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: lets-encrypt-prod
  namespace: cert-manager
spec:
  acme:
    # The ACME server URL for Let's Encrypt
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: your-email@example.com
    # Set to true to enable the HTTP-01 challenge
    solvers:
    - http01:
        ingress:
          class: nginx  # Adjust if you're using a different ingress controller
```
### Apply configuration 
```bash
kubectl apply -f cluster-issuer.yaml

```

### Modify ingress resource
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .Release.Name }}-ingress
  annotations:
    cert-manager.io/cluster-issuer: "lets-encrypt-prod"
spec:
  tls:
  - hosts:
    - {{ .Values.ingress.host }}
    secretName: shop-app-prod-tls  # This is the secret where the TLS certificate will be stored
  rules:
  - host: {{ .Values.ingress.host }}
    http:
      paths:
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: {{ .Release.Name }}-backend
            port: 
              number: 8080
      - path: /
        pathType: Prefix
        backend:
          service:
            name: {{ .Release.Name }}-frontend
            port: 
              number: 80
```

## Redeploy ingress resource
```bash
helm upgrade shop-app-prod --namespace prod ./app-charts/charts/shop-app --values ./app-charts/charts/shop-app/values-prod.yaml
```

### Verify the certificate
```bash
kubectl get secret shop-app-prod-tls -n prod
```

### Access application securely
```bash
https://shop-app-prod.bansikah.ip-dynamic.org
```

### Other Verifications
```bash
## Check if cert is created
kubectl get certificates -n cert-manager
## describe the cluster issuer
kubectl describe clusterissuer lets-encrypt-prod
### check ingress configuration
kubectl describe ingress shop-app-prod-ingress -n prod
### check events of cert manager
kubectl get events -n cert-manager
### Test the applicaton
curl -I https://shop-app-prod.bansikah.ip-dynamic.org
### Check certificate secret
kubectl get secrets -n cert-manager
### get certificate name
kubectl get secrets -n cert-manager
```

## Install cert manager
```bash
kubectl apply --validate=false -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml
```

### Debugging 
```bash
## to see my public ip 
curl ifconfig.me
kubectl delete clusterissuer lets-encrypt-prod
kubectl create -f cluster-issuer.yaml --save-config
kubectl logs -l app=cert-manager -n cert-manager
###  enable ingress
minikube addons disable ingress
minikube addons enable ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
kubectl delete job ingress-nginx-admission-create -n ingress-nginx
kubectl delete job ingress-nginx-admission-patch -n ingress-nginx

```

### install cert bot
``` 
sudo apt install certbot
```

```bash
# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local helm chart repository cache
helm repo update

# Install the CustomResourceDefinitions and the Cert-manager itself
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.12.2/cert-manager.crds.yaml

# Install Cert-manager using Helm
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.12.2



kubectl get certificate,certificaterequest -n prod
kubectl describe certificate shop-app-prod-tls -n prod


sudo cp cert-manager-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```