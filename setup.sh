brew install minikub
minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000
export MINIKUBE_IP=$(minikube ip)
echo "Minikube IP is $MINIKUBE_IP"
minikube ssh
# minikube dashboard # to check state etc
kubectl apply -f wordpress.yaml