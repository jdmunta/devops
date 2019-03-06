
minikube start
kubectl create -f myappvolumes.yaml
kubectl get persistentvolumes
kubectl apply -f myappdb.yaml
kubectl apply -f myappserver.yaml
kubectl get pod
kubectl describe pod myappdb
kubectl describe pod myappserver
minikube service myappserver
