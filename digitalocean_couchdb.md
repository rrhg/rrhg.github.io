
## Managed k8s pq
necesito avanzar.
con la idea de spaces no voy a usar tanto storage
https://www.digitalocean.com/community/questions/managed-kubernetes-programmatic-worker-node-spinup


## no worry about node security because
Worker nodes are built on Droplets, but unlike standard Droplets, worker nodes are managed with the Kubernetes command-line client kubectl and are not accessible with SSH. On both the master nodes and the worker nodes, DigitalOcean maintains the system updates, security patches, operating system configuration and installed packages.

##  multi zone pq
  aparentemente geodns is from $5 to 25 a month.  

        https://www.ctrl.blog/entry/review-cheap-geodns.html  
        https://mattgadient.com/geo-dns-cloudflare-vs-route-53-a-look-and-short-test-results/
        https://www.lowendtalk.com/discussion/144743/does-anyone-use-route53-amazon-aws-geodns  
        
        
----------------   
## No invertir tiempo en kubefed hasta q este en beta y halla mas docs
https://github.com/kubernetes-sigs/kubefed  

----------------  

## No k3s x ahora
Creo q si uso K8s es más probable q otros lo usen. Pq busque k3s en production y federation y no hay mucho. Alomejor las compañías toda in lo ven como para ARM.  

--------------
## Note that Submariner is in the pre-alpha stage, and should not be used for production purposes.
https://submariner.io/


## Offical Apache CouchDB library for Node.js.
https://www.npmjs.com/package/nano

## Spaces
just http calls
un controller o nodejs microservices podria retreive all transactions for last month and send it as an object as an attachment or inline with an http put.


## the problem with managed databases
its only mysql & postgress & I cant find good docs on sync & offline first that is free and I dont have to reinvent the wheel that couchdb & pouchdb already solved. I could try, but for example, when multiple employees in different places, how make the server sync, and to other mobiles(like what transactions numbers should I use).






----------
