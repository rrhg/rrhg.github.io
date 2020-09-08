
Some thoughts & quotes about Dynamic Programming.  :computer:   

1. Dynamically creating something  
    like updating a `list` of calculated values. 

1. Instead of many loops:   
    Save results.  :memo: 
1. Braking the problem into sub problems 
1. Is about finding some work that the naive (usually recursive) solution would repeat multiple times unnecessarily.
   1. Instead is better to store the result of that subproblem & reuse it to avoid extra computation.
1. Used on abstract problems that have the following properties:
   1. Optimal Substructure property.
      1. The problem can :
         1. Be broken in sub problems 
         1. There's an optimal way to solve the sub problems 
   1. Overlapping sub problems 
      1.
      1. 
1.
1. Types of problems:  
   1. Combinatoric (How many)
      1. How many steps from ...
   1. Optimization (Maximum or Minimum)
      1. Minimum steps needed...
   1. Yes or no.  
1. The optimal solution of the high level abstract problem 
   1. depends on the optimal solution 
      1. to the overlapping sub problems 

1. Memoization- store results 
   1. Memoized == cached
1. Optimize a problem by storing intermediaries 
1. Brief Introduction of Dynamic Programming
   1. In the divide-and-conquer strategy, you divide the problem to be solved into subproblems. 
      1. **The subproblems are further divided into smaller subproblems. That task will continue until you get subproblems that can be solved easily.**
      1.  However, in the process of such division, you may encounter the same problem many times.
   1. The basic idea of dynamic programming is to use a table to store the solutions of solved subproblems. If you face a subproblem again, you just need to take the solution in the table without having to solve it again. Therefore, the algorithms designed by dynamic programming are very effective.
1. Iteration vs Recursion 
1. Steps 
   1. Define Objective Function 
   1. Identify Base Cases
   1. Recurrence Relation
   1. Order of computation 
   1. Location of the answer
1.

