## zjvis

### resource-nginx
* 静态资源服务(nginx转发)
* ```shell
  kubectl -n application exec -ti deployment/my-resource-nginx \
      -c busybox -- sh -c "cd /tmp && sh"
  ```
* ```shell
  POD_NAME=$(kubectl -n application get pod \
            -l "app.kubernetes.io/instance=my-resource-nginx" \
            -o jsonpath="{.items[0].metadata.name}")
  for FILE in "docker.io_nginx_1.19.9-alpine.dim" \
      "docker.io_alpine_3.15.0.dim"
  do
      chmod 644 ${FILE} \
          && kubectl cp ${FILE} application/${POD_NAME}:/tmp/${FILE} -c busybox \
          && echo "${FILE} upload done"
  done 
  ```

### kubernetes-dashboard
* k8s 的 dashboard 服务 (使用的是k8s鉴权机制rbac)
* `https://nebula-ops.lab.zjvis.net/#/ops-dev/application/dashboard`

### chart-museum
* chart包管理，  helm 是k8s的包管理软件 类比的话 chart-museum 就是yum源

### phpmyadmin
* `http://phpmyadmin-ops-dev.lab.zjvis.net:32080`
