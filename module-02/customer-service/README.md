oc create configmap customer-openapi-spec --from-file=customer-openapi-spec.json
kamel run -t prometheus.enabled=true -t prometheus.pod-monitor-labels='workshop=camel' -t jolokia.enabled=true -d camel:platform-http -d mvn:org.postgresql:postgresql:42.7.3 --open-api configmap:customer-openapi-spec customer-service.camel.yaml

camel export --gav=com.redhat.lab:customer-service:1.0.0-SNAPSHOT --open-api=customer-openapi-spec.json --runtime=quarkus --directory=./temp --dep=org.postgresql:postgresql:42.7.3 
customer-service.camel.yaml