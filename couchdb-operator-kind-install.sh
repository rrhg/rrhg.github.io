

# requirements :
# kind
# kubectl
# https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-installing-the-operator



kind create cluster --config kind-config-multi-node-cluster.yaml 

echo ----------- 
echo finished creating the cluster with kind
echo to delete cluster : kind delete cluster
echo
echo other options :
echo kubectl cluster-info --context kind-kind
echo kubectl get nodes
echo kind get clusters

echo
echo ----------- starting olm and couchdb-operator installation acording to :
echo "https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-installing-the-operator"

echo
echo ---------- start applying crds.yaml and  olm.yaml

kubectl apply -f crds.yaml
kubectl apply -f olm.yaml

#kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.13.0/crds.yaml
#kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.13.0/olm.yaml

echo
echo "waiting for deployments to be ready"
echo "checking every 30 seconds "
echo

namespace=olm
sec=0
# wait for deployments to be ready
kubectl rollout status -w deployment/olm-operator --namespace="${namespace}"
kubectl rollout status -w deployment/catalog-operator --namespace="${namespace}"

retries=50
until [[ $retries == 0 || $new_csv_phase == "Succeeded" ]]; do
    new_csv_phase=$(kubectl get csv -n "${namespace}" packageserver -o jsonpath='{.status.phase}' 2>/dev/null || echo "Waiting for CSV to appear")
    if [[ $new_csv_phase != "$csv_phase" ]]; then
        csv_phase=$new_csv_phase
        echo "Package server phase: $csv_phase"
    fi
    sleep 30
    retries=$((retries - 1))
    sec=$((sec + 30))
    echo "seconds = $sec"
done

if [ $retries == 0 ]; then
    echo "CSV \"packageserver\" failed to reach phase succeeded"
    exit 1
fi

kubectl rollout status -w deployment/packageserver --namespace="${namespace}"

echo ---------------
echo finished installing olm


echo 
echo ---------- starting kubectl create -f couchdb-operator.yaml
kubectl create -f couchdb-operator.yaml
#kubectl create -f https://operatorhub.io/install/couchdb-operator.yaml


echo
echo "waiting for status of pod in namespace operators to be Running"
echo "trying every 30 seconds"

echo
echo ---------  when finshed, we can try
echo ---------  kubectl get csv -n operators
echo ---------  kubectl get csv -n olm
echo ---------  kubectl get clusterserviceversion -n operators
echo ---------  kubectl get pod -n operators
echo ---------  kubectl exec -it couchdb-operator-7584957dcd-68bx2 bash
echo


sec=0
retries=50
until [[ $retries == 0 || $podstatus == "Running" ]]; do
    #new_csv_phase=$(kubectl get csv -n "${namespace}" packageserver -o jsonpath='{.status.phase}' 2>/dev/null || echo "Waiting for CSV to appear")
    podstatus="$(kubectl describe pod -n operators | grep ^Status: | head -1 | awk '{print $2}' | tr -d '\n')"
    echo
    echo "podstatus = $podstatus"

    #if [[ $new_csv_phase != "$csv_phase" ]]; then
    #    csv_phase=$new_csv_phase
    #    echo "Package server phase: $csv_phase"
    #fi
    sleep 30
    retries=$((retries - 1))
    sec=$((sec + 30))
    echo "seconds = $sec"
done

if [ $retries == 0 ]; then
    echo
    echo "pod in namespace operators failed to reach status Running"
    exit 1
fi



kubectl create namespace my-couchdb
echo ---------
echo
echo "creating namespace my-couchdb"
echo "Operator for Apache CouchDB is configured to watch the namespace my-couchdb (for example, by using an OperatorGroup)."


# here I previously created the cert files

kubectl create secret generic --type=kubernetes.io/tls mycluster-cert --namespace=my-couchdb --from-file=tls.crt=couchdb.pem --from-file=tls.key=couchdb-key.pem --from-file=ca.crt=ca.pem
echo 
echo "created secret mycluster-cert used by the operator as tls certificate for Communication between the Operator and CouchDBCluster management sidecars" 


##############################################################################3
#   * this is till not working. couchdb pods are pending- pulling image of containers
#
# kubectl apply -f couchdb-cluster.yaml
#echo
#echo "creating the couchdb cluster with name my-cluster by applying file couchdb-cluster.yaml"
#
#   kubectl describe couchdbcluster -n my-couchdb
#   kubectl get pod -n my-couchdb
#   k describe pod -n my-couchdb c-mycluster-m-0
#       25 minutes and still  pendind- pulling image of containers
