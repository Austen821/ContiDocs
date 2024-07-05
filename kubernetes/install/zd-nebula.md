## zd-nebula
* `aiworks-backend`
* `nebula-backend`
* `aiworks-frontend`
* `aiworks-frontend-kg-application`
* `aiworks-frontend-kg-construction`
* `aiworks-algorithms`
* `nebula-algorithms`
* `nebula-docs`

### precondition
* mysql or mariadb
* postgresql
* minio
* redis
* jupyterhub

### installation
1. initialize the `mariadb`
    * prepare [aiworks.initialize.mariadb.20240120.sql](resources/aiworks.initialize.mariadb.20221012.sql)
    * prepare [nebula.initialize.mariadb.20240120.sql](resources/nebula.initialize.mariadb.20221012.sql)
2. initialize the `postgresql`
    * prepare [aiworks.initialize.postgresql.20240120.sql](resources/aiworks.initialize.postgresql.20240120.sql)
3. initialize the `minio`
    * prepare `aiworks.initialize.minio.20240120.tar.gz`
4. install `aiworks-backend`
    * prepare [aiworks-backend.values.yaml](resources/aiworks-backend.values.yaml.md)
    * prepare `java-1.0.0-C4f979aa.tgz`
    * install `aiworks-backend` by helm
        + ```shell
          helm install \
              --create-namespace --namespace nebula \
              aiworks-backend \
              ${PWD}/java-1.0.0-C4f979aa.tgz \
              --values aiworks-backend.values.yaml \
              --atomic
          ```
5. install `nebula-backend`
    * prepare [nebula-backend.values.yaml](resources/nebula-backend.values.yaml.md)
    * install `nebula-backend` by helm
        + ```shell
          helm install \
              --create-namespace --namespace nebula \
              nebula-backend \
              ${PWD}/java-1.0.0-C4f979aa.tgz \
              --values nebula-backend.values.yaml \
              --atomic
          ```
6. install `aiworks-frontend`
    * prepare [aiworks-frontend.values.yaml](resources/aiworks-frontend.values.yaml.md)
    * prepare `nginx-1.0.0-C4f979aa.tgz`
    * install `aiworks-frontend` by helm
        + ```shell
          helm install \
              --create-namespace --namespace nebula \
              aiworks-frontend \
              ${PWD}/nginx-1.0.0-C4f979aa.tgz \
              --values aiworks-frontend.values.yaml \
              --atomic
          ```
7. install `aiworks-frontend-kg-application`
   * prepare [aiworks-frontend.kg-application.values.yaml](resources/aiworks-frontend.kg-application.values.yaml.md)
   * install `aiworks-frontend-kg-application` by helm
      + ```shell
          helm install \
              --create-namespace --namespace nebula \
              aiworks-frontend-kg-application \
              ${PWD}/nginx-1.0.0-C4f979aa.tgz \
              --values aiworks-frontend.kg-application.values.yaml \
              --atomic
          ```
8. install `aiworks-frontend-kg-construction`
   * prepare [aiworks-frontend.kg-construction.values.yaml](resources/aiworks-frontend.kg-construction.values.yaml.md)
   * install `aiworks-frontend-kg-construction` by helm
      + ```shell
          helm install \
              --create-namespace --namespace nebula \
              aiworks-frontend-kg-construction \
              ${PWD}/nginx-1.0.0-C4f979aa.tgz \
              --values aiworks-frontend.kg-construction.values.yaml \
              --atomic
          ```
9. install `aiworks-algorithms`
    * prepare [aiworks-algorithms.values.yaml](resources/aiworks-algorithms.values.yaml.md)
    * prepare `flask-1.0.0-C4f979aa.tgz`
    * install `aiworks-algorithms` by helm
        + ```shell
          helm install \
              --create-namespace --namespace nebula \
              aiworks-algorithms \
              ${PWD}/flask-1.0.0-C4f979aa.tgz \
              --values aiworks-algorithms.values.yaml \
              --atomic
          ```
10. install `nebula-algorithms`
     * prepare [nebula-algorithms.values.yaml](resources/nebula-algorithms.values.yaml.md)
     * install `nebula-algorithms` by helm
         + ```shell
           helm install \
               --create-namespace --namespace nebula \
               nebula-algorithms \
               ${PWD}/flask-1.0.0-C4f979aa.tgz \
               --values nebula-algorithms.values.yaml \
               --atomic
           ```
11. install `nebula-docs`
     * prepare [nebula-docs.values.yaml](resources/nebula-docs.values.yaml.md)
    * install `nebula-docs` by helm
       + ```shell
           helm install \
               --create-namespace --namespace nebula \
               nebula-docs \
               ${PWD}/nginx-1.0.0-C4f979aa.tgz \
               --values nebula-docs.values.yaml \
               --atomic
           ```
