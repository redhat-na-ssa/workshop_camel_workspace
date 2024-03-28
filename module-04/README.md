# How to Export Projects

from the projects folders in the module-02 you can run a command like this:

```
camel export \
--gav=com.redhat.lab:customer-service:1.0.0-SNAPSHOT \
--open-api=customer-openapi-spec.json \
--runtime=quarkus \
--directory=../../module-04/customer-service \
--dep=org.postgresql:postgresql:42.7.3 \
customer-service.camel.yaml
```

# To build a container image

```
podman build -f src/main/docker/Dockerfile.jvm -t quarkus/customer-service .  
```

> if you prefer build using Docker just replace `podman` by `docker`

# To build and generate Deployment resources

```
./mvnw clean package \
-Dquarkus.openshift.namespace=camel-sandbox \
-Dquarkus.openshift.name=camel-quarkus \
-Dquarkus.kubernetes.deploy=false \
-Dquarkus.container-image.build=false \
-Dquarkus.container-image.group=camel-sandbox \
-Dquarkus.container-image.builder=openshift \
-Dquarkus.openshift.deployment-kind=deployment \
-Dquarkus.openshift.replicas=1 \
-Dquarkus.openshift.part-of=customer-integration \
-Dquarkus.openshift.route.expose=true \
-Dquarkus.openshift.route.target-port=https \
-Dquarkus.openshift.route.tls.termination=passthrough \
-Dquarkus.openshift.route.tls.insecure-edge-termination-policy=None \
-Dquarkus.openshift.labels.app."openshift.io/runtime"=quarkus \
-Dquarkus.openshift.annotations."app.openshift.io/vcs-url"=https://github.com/username/project-name \
-Dquarkus.openshift.annotations."app.openshift.io/vcs-ref"=main \
-Dquarkus.openshift.annotations."prometheus.io/scrape"="true" \
-Dquarkus.openshift.annotations."prometheus.io/path"=/q/metrics \
-Dquarkus.openshift.annotations."prometheus.io/port"="8080" \
-Dquarkus.openshift.annotations."prometheus.io/scheme"=http \
-Dquarkus.openshift.annotations."app.openshift.io/connects-to"="service-name" \
-Dquarkus.openshift.readiness-probe.http-action-port=8080 \
-Dquarkus.openshift.readiness-probe.http-action-path=/q/health/ready \
-Dquarkus.openshift.readiness-probe.http-action-scheme=http \
-Dquarkus.openshift.resources.requests.cpu=0.5 \
-Dquarkus.openshift.resources.requests.memory=256Mi \
-Dquarkus.openshift.resources.limits.cpu=2 \
-Dquarkus.openshift.resources.limits.memory=1Gi
-Dquarkus.openshift.readiness-probe.initial-delay
-Dquarkus.openshift.readiness-probe.period
-Dquarkus.openshift.readiness-probe.timeout
```
