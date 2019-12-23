
# An attemp to understand the OLM (OperatorLifecycleManager)


## What is the  OLM (Operator Lifecycle Manager)
Is the component of the Operator framework that creates & manages operators.

## Which are the components of the Operator Framework
1. Operator SDK - for creating operators
1. Operatorhub.io - where you push & pull the operator.
1. OLM - for installing & managing operators
1. Operator Metering - for reporting

## But what does the OLM actually do & how is acomplished ?
When the OLM is installed, a bunch of kubernetes resources & operators(controllers/pods/loops) are created which will assist in the creation, updates & other management tasks of the application operator(like couchdb operator, mysql operator, etc).

##

## What is created inside k8s, when you install the OLM ?
1. Two operators
   1. Item 3a
   1. Item 3b
1. Item 2
1. namespaces
   1. Item 3a
   1. Item 3b
 1. CRDs
   1. Item 3a
   1. Item 3b
 1. Item 3
   1. Item 3a
   1. Item 3b
1. Item 3
   1. Item 3a
   1. Item 3b

##
##

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2

