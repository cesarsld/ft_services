
# Build function

function apply_yaml()
{
	kubectl apply -f srcs/$@.yaml > /dev/null
	printf "Deploying $@...\n"
	sleep 2;
	while [[ $(kubectl get pods -l app=$@ -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do
		sleep 1;
	done
	printf "$@ deployed!\n"
}

SERVICES="mysql phpmyadmin nginx wordpress ftps influxdb grafana telegraf"

if [[ $1 = 'clean' ]]
then
	printf "Cleaning all services...\n"
	for SERVICE in $SERVICES
	do
		kubectl delete -f srcs/yaml/$SERVICE.yaml > /dev/null
	done
	kubectl delete -f srcs/ingress.yaml > /dev/null
	printf "Clean complete !\n"
	exit
fi


# Start the cluster if it's not running

if [[ $(minikube status | grep -c "Running") == 0 ]]
then
	minikube start --cpus=2 --memory 4000 --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000
	minikube addons enable metrics-server
	minikube addons enable ingress
	minikube addons enable dashboard
fi

MINIKUBE_IP=$(minikube ip)

# Set the docker images in Minikube

eval $(minikube docker-env)

# MINIKUBE_IP EDIT
cp srcs/pods/mysql/wordpress.sql srcs/pods/mysql/wordpress-tmp.sql
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/pods/mysql/wordpress-tmp.sql
cp srcs/pods/wordpress/wp-config.php srcs/pods/wordpress/wp-config-tmp.php
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/pods/wordpress/wp-config-tmp.php
# cp srcs/ftps/scripts/start.sh srcs/ftps/scripts/start-tmp.sh
# sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/ftps/scripts/start-tmp.sh

# Build Docker images

printf "Building Docker images...\n"

docker build -t services/influxdb srcs/pods/influxdb
docker build -t services/mysql srcs/pods/mysql
docker build -t services/wordpress srcs/pods/wordpress
docker build -t services/nginx srcs/pods/nginx
# docker build -t services/ftps srcs/ftps
docker build -t services/grafana srcs/pods/grafana

# for SERVICE in $SERVICE_LIST
# do
# 	apply_yaml $SERVICE
# done

kubectl apply -f srcs/yaml/grafana.yaml
kubectl apply -f srcs/yaml/influxdb.yaml
kubectl apply -f srcs/yaml/mysql.yaml
kubectl apply -f srcs/yaml/nginx.yaml
kubectl apply -f srcs/yaml/phpmyadmin.yaml
kubectl apply -f srcs/yaml/wordpress.yaml

# kubectl apply -f srcs/ingress.yaml > /dev/null

# Import Wordpress database
# kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE wordpress;'
# kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < srcs/wordpress/files/wordpress-tmp.sql

# rm -rf srcs/ftps/scripts/start-tmp.sh
rm -rf srcs/pods/mysql/wordpress-tmp.sql
rm -rf srcs/pods/mysql/wp-config-tmp.sql

server_ip=`minikube ip`
echo -ne "\033[1;33m+>\033[0;33m IP : $server_ip \n"