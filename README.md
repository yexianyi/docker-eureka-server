### Usage:
```
docker network create eureka-net
docker run -it --rm -e EUREKA_SERVER_HOSTNAME=peer_host_1 -e EUREKA_SERVER_PORT=8761 -e EUREKA_SERVER_PEER_URL=http://192.168.1.10:8763/eureka -p 8761:8761 -d yexianyi/eureka-server
docker run -it --rm -e EUREKA_SERVER_HOSTNAME=peer_host_2 -e EUREKA_SERVER_PORT=8762 -e EUREKA_SERVER_PEER_URL=http://192.168.1.10:8761/eureka -p 8762:8762 -d yexianyi/eureka-server
docker run -it --rm -e EUREKA_SERVER_HOSTNAME=peer_host_3 -e EUREKA_SERVER_PORT=8763 -e EUREKA_SERVER_PEER_URL=http://192.168.1.10:8762/eureka -p 8763:8763 -d yexianyi/eureka-server
```
#### Note:
1) 192.168.1.10: my local machine where docker engine installed.
2) EUREKA_SERVER_HOSTNAME: server name used for distinguish diff eureka registry server. (Must be unique, otherwise node replicas will not work.)
3) EUREKA_SERVER_PORT: the port used for access eureka dashboard. (Must be same with the followed "-p" parameter's)
4) EUREKA_SERVER_PEER_URL: eureka peer server registry url. In this example, the regiester seq is: 

peer_host_1 -> peer_host_3

peer_host_2 -> peer_host_1

peer_host_3 -> peer_host_2

(This seq is not important, because eureka cluster will syn them automatically.)
