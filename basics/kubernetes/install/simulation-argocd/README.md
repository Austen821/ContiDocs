# simulation-argocd

## installation basic
1. install `ingress-nginx`
    * prepare [ingress-nginx.application.yaml](resources/ingress-nginx.application.yaml.md)
    * ```shell
      kubectl -n argocd apply -f ingress-nginx.application.yaml
      ```