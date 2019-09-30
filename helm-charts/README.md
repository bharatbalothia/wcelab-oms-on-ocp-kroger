# HELM commands used

## DB2
* Assigned the privileged SCC to the user default. This is required as the DB2 needs some root privileges. a new ServiceAccount db2-sa is created but the helm chart uses the default serviceaccount.
```
oc adm policy add-scc-to-user privileged system:serviceaccount:oms-dev:default
```
* dynamicStorageProvisioning is enabled. Since DB2 requires RWO, 'ibmc-block-bronze' is selected.
* command to execute the helm chart. 
```
helm install --namespace oms-dev --tiller-namespace tiller --name oms-db2 -f ibm-db2oltp-dev/values.yaml stable/ibm-db2oltp-dev
```

## MQ

```
helm install --namespace oms-dev --tiller-namespace tiller --name oms-mq -f ibm-mqadvanced-server-dev/values.yaml stable/ibm-mqadvanced-server-dev
```
