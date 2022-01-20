docker build -t ayman30/multi-client-k8s:latest -t ayman30/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t ayman30/multi-server-k8s:latest -t ayman30/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t ayman30/multi-worker-k8s:latest -t ayman30/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push ayman30/multi-client-k8s:latest
docker push ayman30/multi-server-k8s:latest
docker push ayman30/multi-worker-k8s:latest

docker push ayman30/multi-client-k8s:$SHA
docker push ayman30/multi-server-k8s:$SHA
docker push ayman30/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ayman30/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=ayman30/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=ayman30/multi-worker-k8s:$SHA