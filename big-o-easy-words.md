

# O(1)   
### constant   
```
def myprint(array1):
    print(array1[0]# the time it takes to execute this does NOT depends on the input size
```

* time does NOT change   
   or   
* space(ram) does NOT change  
> not dependent of input size.  
> time or space(ram) used by the algorithm itself does NOT change.   
> The memory complexity of an algorithm is the amount of memory it uses.
> space(ram) used by the algorithm does not include space used by the input.   
> Only local variables constitute work memory.    



AKA :
1. Constant Time
1. An algorithm is said to have a constant time when it is not dependent on the input data (n). 
1. space complexity of O(1) means that the space required by the algorithm to process data is constant; it does not grow with the size of the data on which the algorithm is operating.
1. use only O(1) memory   



# O(n)   
### linear   

* if input=1:  time=1t  or space=1s
* if input=10: time=10t or space=10s
* this algorithm time(& space) increases at most linearly with the size of the input data   
*    
```
for i in array1:
    do_something(i)...# the time it takes to execute this depends on the input size
```


# O(log n)   
### logarithmic     
* goes between O(1) & O(n) because it only uses a subset (but not all) of the input.   
* for example a tree binary search will only work with a few nodes  
*



https://towardsdatascience.com/understanding-time-complexity-with-python-examples-2bda6e8158a7



# O(n log n)   linear * log
### logarithmic     
* goes between O(1) & O(n) because it only uses a subset (but not all) of the input.   
* for example a tree binary search will only work with a few nodes  
*


# O(n + a)   
### O(input1 + input2)   
* when we have 2 inputs(ex. 2 lists) & we run a NOT NESTED for loop on each one  
```
for i in array1:
    ...
for i in array2:
    ...
```   

# O(n * a)   
### O(input1 * input2)   
* when we have 2 inputs(ex. 2 lists) & we run a NESTED for loop on each one  
```
for i1 in array1:
    for i2 in array2:
        print(i1 + i2)
``` 



# O(n^2)   quadratic
*   

```
for i1 in array1:
    for i2 in array1:
        print(i1 + i2)
    ...
   
   
# O(2^n)   exponential


