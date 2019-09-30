# HELM commands used

## DB2

```
helm install --namespace oms-dev --tiller-namespace tiller --name oms-db2 -f ibm-db2oltp-dev/values.yaml stable/ibm-db2oltp-dev
```

## MQ

```
helm install --namespace oms-dev --tiller-namespace tiller --name oms-mq -f ibm-mqadvanced-server-dev/values.yaml stable/ibm-mqadvanced-server-dev
```
