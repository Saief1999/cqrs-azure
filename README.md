## Overview

This is a CQRS implementation using Azure Services.

Full presentation can be found here : [Presentation link](https://docs.google.com/presentation/d/1dFtx48FfI9SLz0w9gUmCfHPFU4FizrWqacQEvBQa6wg/edit#slide=id.gd1d1ee2289_0_139)

## Quickstart

1. Create terraform infrastructure

2. deploy the azure function ( after building in with `npm run build` )

3. Create the event subscription in the terraform code, to link the azure function to event grid.

4. change  Eventgrid endpoint + Token and comsos connection string in the config server (on github) to match the new ones.

5. in each of the services ( search, upsert, gateway ), we package them again : 

```bash
./mvnw clean package -DskipTests
```

6. We deploy them on Azure spring Apps :

```bash
az spring app deploy     --resource-group dev-cqrs-rg     --service dev-cqrs-springcloud     --name search-microservice     --artifact-path target/search-microservice-0.0.1-SNAPSHOT.jar --deployment default
```

```bash
az spring app deploy     --resource-group dev-cqrs-rg     --service dev-cqrs-springcloud     --name upsert-microservice     --artifact-path target/upsert-microservice-0.0.1-SNAPSHOT.jar --deployment default
```

```bash
az spring app deploy     --resource-group dev-cqrs-rg     --service dev-cqrs-springcloud     --name gateway-service    --artifact-path target/gateway-service-0.0.1-SNAPSHOT.jar --deployment default
```

