# nginx-chart

### How to test Horizontal Pod Autoscaler (HPA) ?

1. Install "hey" `brew install hey`

2. Run the following command to stress test the nginx deployment

```bash
hey -z 2m -c 100 -m GET http://nginx.minikube.local/
```

3. Check the HPA metrics

```bash
kubectl get hpa
```

You will notice that after you run the stress test, the number of replicas will increase to the value specified in the `maxReplicas` field of the HPA.