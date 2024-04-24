#/bin/sh 

echo "==== Deploying order-connector===="

oc delete configmap order-connector-config > /dev/null 2>&1
oc create configmap order-connector-config --from-file=../module-02/order-connector/application.properties

kamel run -d camel:http -p configmap:order-connector-config -t prometheus.enabled=true -t prometheus.pod-monitor-labels='workshop=camel' \
 -t jolokia.enabled=true --wait ../module-02/order-connector/order-connector.camel.yaml

echo "========"

echo "==== Deploying customer-service===="

oc delete configmap customer-service-config > /dev/null 2>&1
oc create configmap customer-service-config --from-file=../module-02/customer-service/application.properties

oc delete configmap customer-openapi-spec > /dev/null 2>&1
oc create configmap customer-openapi-spec --from-file=../module-02/customer-service/customer-openapi-spec.json

kamel run -d camel:platform-http -d mvn:org.postgresql:postgresql:42.7.3 -p configmap:customer-service-config -t prometheus.enabled=true -t prometheus.pod-monitor-labels='workshop=camel' \
-t jolokia.enabled=true --open-api configmap:customer-openapi-spec --wait ../module-02/customer-service/customer-service.camel.yaml

echo "========"

echo "==== Deploying customer-connector===="

oc delete configmap customer-connector-config > /dev/null 2>&1
oc create configmap customer-connector-config --from-file=../module-02/customer-connector/application.properties

kamel run -d camel:http -p configmap:customer-connector-config -t prometheus.enabled=true -t prometheus.pod-monitor-labels='workshop=camel' -t jolokia.enabled=true \
--wait ../module-02/customer-connector/customer-connector.camel.yaml

echo "========"