## How to Deploy using Camel K CLI

    oc create configmap customer-connector-config --from-file=application.properties

    kamel run -d camel:http -p configmap:customer-connector-config -t prometheus.enabled=true -t prometheus.pod-monitor-labels='workshop=camel' -t jolokia.enabled=true customer-connector.camel.yaml 

## How to Export to a Java project using Camel JBang

    jbang run '-Dcamel.jbang.version=4.6.0-SNAPSHOT' camel@apache/camel export \
    --gav=com.redhat.lab:customer-connector:1.0.0-SNAPSHOT \
    --runtime=quarkus --directory=customer-connector \
    ../module-02/customer-connector/*.camel.yaml