# kubernetes-dashboard

## main usage
* General-purpose web UI for Kubernetes clusters

## precondition
* [kind.cluster](/basics/kubernetesernetes/kind-cluster.md)
* [ingress-nginx](ingress-nginx.md)
* [cert-manager-dns01](cert-manager-dns01.md)

## operation
1. prepare [kubernetes-dashboard.values.yaml](resources/kubernetes-dashboard.values.yaml.md)
2. prepare images
    * ```shell
      DOCKER_IMAGE_PATH=/root/docker-images && mkdir -p ${DOCKER_IMAGE_PATH}
      BASE_URL="https://resource.cnconti.cc:32443/docker-images"
      for IMAGE in "docker.io_kubernetesui_dashboard_v2.7.0.dim" \
          "docker.io_kubernetesui_metrics-scraper_v1.0.9.dim"
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
      for IMAGE in "docker.io/kubernetesui/dashboard:v2.7.0" \
          "docker.io/kubernetesui/metrics-scraper:v1.0.9"
      do
          DOCKER_TARGET_IMAGE=$DOCKER_REGISTRY/$IMAGE
          docker tag $IMAGE $DOCKER_TARGET_IMAGE \
              && docker push $DOCKER_TARGET_IMAGE \
              && docker image rm $DOCKER_TARGET_IMAGE
      done
      ```
3. install `kubernetes-dashboard` by helm
    * ```shell
      helm install \
          --create-namespace --namespace basic-components \
          kubernetes-dashboard \
          https://resource.cnconti.cc:32443/charts/kubernetes.github.io/dashboard/kubernetes-dashboard-6.0.8.tgz \
          --values kubernetes-dashboard.values.yaml \
          --atomic
      ```

## test
1. Check connectivity
    * ```shell
      curl --insecure --header 'Host: kubernetes-dashboard.local' https://localhost:32443
      ```
2. TODO create readonly token

## uninstall
1. uninstall `kubernetes-dashboard`
    * ```shell
      helm -n basic-components uninstall kubernetes-dashboard
      ```
