docker build -t nahmed105/multi-client:latest -t nahmed105/multi-client:$SHA ./client/Dockerfile ./client
docker build -t nahmed105/multi-server:latest nahmed105/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nahmed105/multi-worker:latest nahmed105/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nahmed105/multi-client:latest
docker push nahmed105/multi-server:latest
docker push nahmed105/multi-worker:latest

docker push nahmed105/multi-client:$SHA
docker push nahmed105/multi-server:$SHA
docker push nahmed105/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nahmed105/multi-server:$SHA
kubectl set image deployments/client-deployment server=nahmed105/multi-client:$SHA
kubectl set image deployments/worker-deployment server=nahmed105/multi-worker:$SHA
