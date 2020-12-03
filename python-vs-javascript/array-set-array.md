
When converting from array to set (to remove duplicates) & converting back to array, can we just use brackets [] or the built in function ? 

No, we need spreading, except when using python list(), which is smarter than javascript new Array()



```   
python:
  l = [1,2,3,3]
  
  s = [set(l)]
  print(s)    # [{1, 2, 3}]
  
  s2 = [*set(l)]
  print(s2)   # [1, 2, 3]
  
  s3 = list(set(l))       <--- notable diff with javascript new Array()
  print(s3)   # [1, 2, 3]
  
  
  
javascript:
  const l = [1,2,3,3]
  
  s = [new Set(l)]
  console.log(s)   // [ Set(3) { 1, 2, 3 } ]
  
  s2 = [...new Set(l)]
  console.log(s2)   // [ 1, 2, 3 ]
  
  s3 = new Array(new Set(l))       <------------- notable diff with python list()
  console.log(s3)   // [ Set(3) { 1, 2, 3 } ]
  
```
