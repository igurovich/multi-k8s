docker build -t igorgurovich/multi-client:latest -t igorgurovich/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t igorgurovich/multi-server:latest -t igorgurovich/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t igorgurovich/multi-worker:latest -t igorgurovich/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push igorgurovich/multi-client:latest
docker push igorgurovich/multi-server:latest
docker push igorgurovich/multi-worker:latest
docker push igorgurovich/multi-client:$SHA
docker push igorgurovich/multi-server:$SHA
docker push igorgurovich/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=igorgurovich/multi-client:$SHA
kubectl set image deployments/server-deployment server=igorgurovich/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=igorgurovich/multi-worker:$SHA