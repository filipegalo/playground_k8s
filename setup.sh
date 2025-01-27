helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/aslafy-z/helm-git
helm plugin install https://github.com/jkroepke/helm-secrets

minikube addons enable ingress
minikube addons enable ingress-dns
minikube addons enable metrics-server

echo "nameserver $(minikube ip)" | sudo tee -a /etc/resolver/minikube.local
echo "search_order 1" | sudo tee -a /etc/resolver/minikube.local
echo "timeout 5" | sudo tee -a /etc/resolver/minikube.local
