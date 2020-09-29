
### IN javascript, the spread operator do the same in these situations :   

`const f = (...myarray) => doSomething`

`f(...otherArray)`


### But, in Python, these 2 do something completely difference :

`def f(*mylist): doSomething` means accept a variable(unknown) number of arguments & put them in an iterable(tuple) named args

`f(*anotherlist)` means unpack the list. ( the same as javascript spread operator)
