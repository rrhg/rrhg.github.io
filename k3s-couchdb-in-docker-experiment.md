
1/04/20  
u4gb  
174.138.39.133  
clud firewall port 22 ssh only in  


https://stackoverflow.com/questions/47017801/docker-curl-to-other-container-in-same-host


    docker network create mynetwork



https://docs.docker.com/network/bridge/
    # Containers connected to the same user-defined bridge network automatically expose all ports to each other, and no ports to the outside world.
    # The docker network command supports creating networks for communication among containers without the need to expose or publish specific ports, because the containers connected to the network can communicate with each other over any port. 
    
                                # esto esta mal o innecesario
                               # The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime. EXPOSE does not make the ports of the container accessible to the host. makes it available only for inter-container communication


Clean up  

    docker container stop servertest
    docker network rm mynetwork


https://phusion.github.io/baseimage-docker/
Ioiij
Thanks 

https://docs.docker.com/config/containers/multi-service_container/
