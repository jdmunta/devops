
minikube start
kubectl create -f myappvolumes.yaml
kubectl create secret generic myappdb-pass --from-literal=password=myapp
