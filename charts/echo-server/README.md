# echo-server-chart

This Helm chart deploys a simple echo server that returns information about the HTTP request it receives. The application code is available at [filipegalo/echo-server](https://github.com/filipegalo/echo-server).

## Features

- Configurable image repository and tag
- Ingress support with customizable host and paths
- Resource limits and requests
- Horizontal Pod Autoscaling (HPA) with configurable metrics
- Pod anti-affinity for high availability
- Customizable service type and port

## Configuration

See the [values.yaml](values.yaml) file for the full list of configurable parameters.

### How to test Horizontal Pod Autoscaler (HPA) ?

1. Install "hey" `brew install hey`

2. Run the following command to stress test the nginx deployment

```bash
hey -z 2m -c 100 -m GET http://hello.minikube.local/
```

3. Check the HPA metrics

```bash
kubectl get hpa
```

You will notice that after you run the stress test, the number of replicas will increase to the value specified in the `maxReplicas` field of the HPA.