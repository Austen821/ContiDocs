## redis-cluster修复
```shell
PVC_NAME="pvc-b2c586af-a56d-4e4a-9b5c-4db88088150c"
cp /var/lib/kubelet/plugins/kubernetes.io/csi/pv/${PVC_NAME}/globalmount/appendonly.aof /home/redis/
docker run --rm -ti \
    -v /var/lib/kubelet/plugins/kubernetes.io/csi/pv/${PVC_NAME}/globalmount:/tmp/fix \
    docker-registry-ops-test.lab.zjvis.net:32443/docker.io/bitnami/redis-cluster:6.2.2-debian-10-r0 \
    redis-check-aof --fix /tmp/fix/appendonly.aof
```
