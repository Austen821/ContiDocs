# k8s installation

## main usage
* create a local k8s cluster
* kubernetes: `v1.25.6`

## precondition
* prepare the machine
    + It is recommended that the machine system be `CentOS-Stream-8`
    + be sure your machine have `2 cores` and `4G memory` at least
* [kubernetes binary tools](binary_tools.md)
    + kind
    + helm
    + kubectl
* [installed docker-ce](/docker/installation.md)

## operation
1. prepare images
    * ```shell
      DOCKER_IMAGE_PATH=/root/docker-images && mkdir -p $DOCKER_IMAGE_PATH
      BASE_URL="https://resource.cnconti.cc:32443/docker-images"
      IMAGE="docker.io_kindest_node_v1.25.6.dim"
      IMAGE_FILE=$DOCKER_IMAGE_PATH/$IMAGE
      if [ ! -f $IMAGE_FILE ]; then
          curl -fo $IMAGE_FILE -L $BASE_URL/$IMAGE \
              && docker image load -i $IMAGE_FILE \
              && rm -f $IMAGE_FILE
      fi
      ```
2. prepare [kind.cluster.yaml](resources/kind.cluster.yaml.md) as file `/tmp/kind.cluster.yaml`
3. prepare [kind.with.registry.sh](resources/kind.with.registry.sh.md) as file `/tmp/kind.with.registry.sh`
4. install `kind-cluster`
    * ```shell
      bash /tmp/kind.with.registry.sh /tmp/kind.cluster.yaml \
          /root/bin/kind /root/bin/kubectl
      ```
5. check `kind-cluster`
    * ```shell
      kubectl -n kube-system wait --for=condition=ready pod --all \
          && kubectl get pod --all-namespaces
      ```

## uninstall
1. uninstall kind-cluster `kind`
    * ```shell
      kind delete cluster --name kind
      ```
