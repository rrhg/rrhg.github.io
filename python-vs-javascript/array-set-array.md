
When converting from array to set (to remove duplicates) & converting back to array, can we jus use brackets [] ?

No, we need spreading, except when using python list(), which is smarter than javascript new Array()



```   
python:
 14 l = [1,2,3,3]
 15 
 16 s = [set(l)]
 17 print(s)    # [{1, 2, 3}]
 18 
 19 s2 = [*set(l)]
 20 print(s2)   # [1, 2, 3]
 21 
 22 s3 = list(set(l))       <--- notable diff with javascript new Array()
 23 print(s3)   # [1, 2, 3]
 24 
 25 
 26 
 27 js:
 28 const l = [1,2,3,3]
 29 
 30 s = [new Set(l)]
 31 console.log(s)   // [ Set(3) { 1, 2, 3 } ]
 32 
 33 s2 = [...new Set(l)]
 34 console.log(s2)   // [ 1, 2, 3 ]
 35 
 36 s3 = new Array(new Set(l))       <------------- notable diff with python list()
 37 console.log(s3)   // [ Set(3) { 1, 2, 3 } ]
 38 
```
