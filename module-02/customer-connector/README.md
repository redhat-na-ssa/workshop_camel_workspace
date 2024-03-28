oc create configmap customer-connector-config --from-file=application.properties
kamel run -d camel:http -p configmap:customer-connector-config -t prometheus.enabled=true -t prometheus.pod-monitor-labels='workshop=camel' -t jolokia.enabled=true customer-connector.camel.yaml 

camel export --gav=com.redhat.lab:customer-connector:1.0.0-SNAPSHOT --runtime=quarkus --directory=./customer-connector customer-connector.camel.yaml