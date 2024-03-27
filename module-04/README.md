# How to Export Projects

from the projects folders in the module-02 you can run a command like this:

        camel export --gav=com.redhat.lab:customer-service:1.0.0-SNAPSHOT --open-api=customer-openapi-spec.json --runtime=quarkus --directory=../../module-04/customer-service --dep=org.postgresql:postgresql:42.7.3 customer-service.camel.yaml