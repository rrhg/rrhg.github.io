
## can context be used with Redux in the same React App ?

## can we have many different contexts for different components in the same React App ?
does NOT have to be global to the whole app, but can be applied to one part of your tree and you can (and probably should) have multiple logically separated contexts in your app.


### Summary of how to use context


Why is recommended to set a default value when creating the context ?
Because we get better auto complete in the IDE (vs code). Functions cold be empty because the real function will be pass in value in context.Provider 


Why pass value in context.Provider if we already assigned a default?

