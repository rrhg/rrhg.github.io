
# An attemp to understand the OLM (Operator Lifecycle Manager)

For a more detailed & technical explanation see [Understanding the OLM by Red Hat Openshift documentation](https://docs.openshift.com/container-platform/4.1/applications/operators/olm-understanding-olm.html)

## Here are some notes in my own words for creating a mental model.   

## What is the  OLM ?
Is the component of the [Operator Framework](https://github.com/operator-framework) that install & manages operators.

## Which are the components of the Operator Framework
1. Operator SDK - for building operators.
1. Operatorhub.io - to store & share operators.
1. OLM - to install & manage operators.
1. Operator Metering - for reporting.

## But what does the OLM actually do & how ?
The OLM is actually a framework. When it is [installed](https://github.com/operator-framework/operator-lifecycle-manager/blob/master/doc/install/install.md), a bunch of kubernetes resources are created which help & oversee the installation, updates, and management of the lifecycle of all of the Operators (and their associated services) running across a Kubernetes cluster. Let's talk about all those resources and their purpose.

## Application operators vs OLM operators vs operators
But before going any further, there's a clarification I think should be pointed out.  
Application operator(couchdb operator, mysql operator, etc) is the operator that will be managed by the OLM.  
OLM operators(olm-operator & catalog-operator) are 2 adicional operators which are components of the OLM framework.  
Sometimes, the documentation just says "operators" and can be a source of confusion if you are not sure which one are referencing.  


## What resources are created inside k8s, when you [install](https://github.com/operator-framework/operator-lifecycle-manager/blob/master/doc/install/install.md) the OLM ?
1. kind: CustomResourceDefinition
   1. clusterserviceversions (csv) - 
      1. represents an Operator(& version) that should be running on the cluster, 
      1. including requirements and install strategy.
      1. describes a template for the operator Deployment
   1. installplans - Represents a plan to install and resolve dependencies for Cluster Services.
   1. subscriptions - Subscribes service catalog to a source and channel to recieve updates for packages. _also used to install new operators_.
   1. catalogsources - A source configured to find packages and updates.
   1. operatorgroups - A grouping of namespaces for usage with an operator.
   1. 
1. kind: Namespace
   1. olm - 
   1. operators -
1. kind: ClusterRole
   1. system:controller:operator-lifecycle-manager -
1. kind: ClusterRoleBinding
   1. olm-operator-binding-olm -
1. kind: Deployment
   1. olm-operator
1. kind: Deployment
   1. catalog-operator
1. kind: ClusterRole
   1. aggregate-olm-edit -
   1. aggregate-olm-view -
1.kind: OperatorGroup
   1. global-operators -
   1. olm-operators -
1. kind: ClusterServiceVersion -
   1. packageserver - Represents an Operator package that is available from a given CatalogSource which will resolve to a ClusterServiceVersion.
1. kind: CatalogSource
   1. operatorhubio-catalog -

## How do I install an application operator with OLM?
Create a subscription.yaml as explained [here](https://operator-framework.github.io/olm-book/docs/how-do-i-install-my-operator-with-olm.html) and then run :
**kubectl apply -f Subscription.yaml**


## How does the OLM updates the application operators?
Of the 2 OLM operators, the Catalog Operator is responsible for watching CatalogSources for updates to packages in channels and upgrading them (optionally automatically) to the latest available versions.  

## Does that means that when the developer pushes a new version of the application operator to operatorhub.io it can automatically updated in my cluster?
I don’t know. Maybe yes. See https://github.com/operator-framework/operator-lifecycle-manager/blob/master/README.md#discovery-catalogs-and-automated-upgrades

##

#### clusterserviceversions

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
