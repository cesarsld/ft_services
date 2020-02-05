
brew update
brew install minikube
minikube addons enable ingress
minikube addons enable metrics-server

export MINIKUBE_HOME=~/

cp -avR srcs/pods $MINIKUBE_HOME/.minikube/files/srcs &> /dev/null

minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000
export MINIKUBE_IP=$(minikube ip)
echo "Minikube IP is $MINIKUBE_IP"

minikube ssh 'docker build -t services/nginx /srcs/pods/nginx/'
minikube ssh 'docker build -t services/influxdb /srcs/pods/influxdb/'
minikube ssh 'docker build -t services/grafana /srcs/pods/grafana'
minikube ssh 'docker build -t services/mysql /srcs/pods/mysql'
minikube ssh 'docker build -t services/phpmyadmin /srcs/pods/phpmyadmin'

kubectl apply -f srcs/yaml/nginx.yaml
kubectl apply -f srcs/yaml/influxdb.yaml
kubectl apply -f srcs/yaml/grafana.yaml
kubectl apply -f srcs/yaml/mysql.yaml
kubectl apply -f srcs/yaml/phpmyadmin.yaml

server_ip=`minikube ip`
echo -ne "\033[1;33m+>\033[0;33m IP : $server_ip \n"