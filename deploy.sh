docker build -t angelo152/multi-client:latest -t angelo152/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t angleo152/multi-server:latest -t angelo152/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t angelo152/multi-worker:latest -t angelo152/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push angelo152/multi-client:latest
docker push angelo152/multi-server:latest
docker push angelo152/multi-worker:latest

docker push angelo152/multi-client:$SHA
docker push angelo152/multi-server:$SHA
docker push angelo152/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=angelo152/multi-server:$SHA
kubectl set image deployments/client-deployment client=angelo152/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=angelo152/multi-worker:$SHA