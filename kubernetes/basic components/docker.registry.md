# docker registry

## main usage
* a registry for docker

## conceptions
* none

## purpose
* setup docker registry
* test docker registry

## precondition
* [kind.cluster](/kubernetes/kind-cluster.md)
* [ingress-nginx](/kubernetes/basic%20components/ingress.nginx.md)
* [cert-manager](/kubernetes/basic%20components/cert.manager.md)

## do it
1. prepare images
    * ```shell
      DOCKER_IMAGE_PATH=/root/docker-images && mkdir -p ${DOCKER_IMAGE_PATH}
      BASE_URL="https://resource.cnconti.cc/docker-images"
      # BASE_URL="https://resource-ops.lab.zjvis.net:32443/docker-images"
      for IMAGE in "docker.io_registry_2.7.1.dim" \
          "docker.io_httpd_2.4.56-alpine3.17.dim" \
          "docker.io_busybox_1.33.1-uclibc.dim"
      do
          IMAGE_FILE=$DOCKER_IMAGE_PATH/$IMAGE
          if [ ! -f $IMAGE_FILE ]; then
              TMP_FILE=$IMAGE_FILE.tmp \
                  && curl -o "$TMP_FILE" -L "$BASE_URL/$IMAGE" \
                  && mv $TMP_FILE $IMAGE_FILE
          fi
          docker image load -i $IMAGE_FILE && rm -f $IMAGE_FILE
      done
      DOCKER_REGISTRY="localhost:5000"
      for IMAGE in "docker.io/registry:2.7.1"
      do
          DOCKER_TARGET_IMAGE=$DOCKER_REGISTRY/$IMAGE
          docker tag $IMAGE $DOCKER_TARGET_IMAGE \
              && docker push $DOCKER_TARGET_IMAGE \
              && docker image rm $DOCKER_TARGET_IMAGE
      done
      ```
2. create `docker-registry-secret`
    * ```shell
      # create PASSWORD
      PASSWORD=($((echo -n $RANDOM | md5sum 2>/dev/null) || (echo -n $RANDOM | md5 2>/dev/null)))
      # Make htpasswd
      docker run --rm --entrypoint htpasswd httpd:2.4.56-alpine3.17 -Bbn admin ${PASSWORD} > ${PWD}/htpasswd
      # NOTE: username should have at least 6 characters
      kubectl -n basic-components create secret generic docker-registry-secret \
          --from-literal=username=admin \
          --from-literal=password=${PASSWORD} \
          --from-file=${PWD}/htpasswd -o yaml --dry-run=client \
          | kubectl -n basic-components apply -f -
      ```
3. prepare [docker.registry.values.yaml](resources/docker.registry.values.yaml.md)
4. install by helm
    *  NOTE: `https://resource-ops.lab.zjvis.net:32443/charts/helm.twun.io/docker-registry-1.14.0.tgz`
    * ```shell
      helm install \
          --create-namespace --namespace basic-components \
          my-docker-registry \
          https://resource.cnconti.cc/charts/helm.twun.io/docker-registry-1.14.0.tgz \
          --values docker.registry.values.yaml \
          --atomic
      ```
5. configure ingress with tls
    * NOTE: ingress in helm chart is not compatible enough for us, we have to install ingress manually
    * prepare [docker.registry.ingress.yaml](resources/docker.registry.ingress.yaml.md)
    * apply ingress `my-docker-registry-ingress`
        + ```shell
          kubectl -n basic-components apply -f docker.registry.ingress.yaml
          ```

## test
1. check with docker-registry
   * ```shell
     echo '127.0.0.1 docker-registry.local' >> /etc/hosts \
         && IMAGE=docker.io/busybox:1.33.1-uclibc \
         && TARGET_IMAGE=docker-registry.local/$IMAGE \
         && docker tag $IMAGE $TARGET_IMAGE \
         && docker push $TARGET_IMAGE \
         && docker image rm $IMAGE \
         && docker image rm $TARGET_IMAGE \
         && docker pull $TARGET_IMAGE \
         && echo success
     ```

## uninstall
1. delete ingress `my-docker-registry-ingress`
    * ```shell
      kubectl -n basic-components delete ingress my-docker-registry-ingress
      ```
2. uninstall `my-docker-registry`
    * ```shell
      helm -n basic-components uninstall my-docker-registry \
          && kubectl -n basic-components delete pvc my-docker-registry
      ```
