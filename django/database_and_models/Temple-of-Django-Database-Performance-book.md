Temple of Django Database Performance book   

Things I'm reading about

Profiling :   
1. With “New Relic, an Application Performance Monitoring service whose major benefit is collecting in-depth information about your application’s performance”   
   1. helps visualize what queries are slow & what python code is slow
   1. use Apdex
   1. Apdex is an open standard for measuring software performance
   1. how mark important page or api endpoints
   1. how establish alerts for minimun performance expectations
   1. has a free plan for one user: https://newrelic.com/pricing
   1. 8-29-2020
1. slow query log (have to be turned on in database conf)
1. debug toolbar
1. In the database with query plans
1.
1.
1.
1. Chapter 3
   1. Using select_related to avoid the N+1 problem
      1. profile = Profile.objects.select_related('user').all()
