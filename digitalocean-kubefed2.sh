

  
  
    kubectl config use-context cluster1


     kubefedctl join cluster1 --cluster-context cluster1 \
        --host-cluster-context cluster1 --v=2
     kubefedctl join cluster2 --cluster-context cluster2 \
        --host-cluster-context cluster1 --v=2
        
        
 Check the status of the joined clusters by using the following command.

kubectl -n kube-federation-system get kubefedclusters

NAME       READY   AGE
cluster1   True    1m
cluster2   True    1m
