
1. Each Django view inserts:   
   1. a special property in the context, or   
   1. an html element with a special id   
1. React initializers looks for this property
   1. ```if (context.has("QUESTIONS")) {... ```, or
   1. ```if (document.getElementById("questions-mount")) {... ```   
1. If found, then the correspending React components are mounted in the router   
```
let routes = [ ...  (include the component & path)   
...
ReactDOM.render(
  <Provider store={store.getStore()}>
    <Router routes={routes} history={browserHistory} />
  </Provider>,
    rootElement  // <-this can be the same element the initializer just found
  )
```
