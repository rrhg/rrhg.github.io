> `importlib.import_module` allow you to use variables while `import` does not  

### why ?  

* Sometimes we don't know which modules would need to be imported until runtime.
* Assume we have a bunch of modules
* & we would only need to import a subset of them.
* depending on what functionality(or app or microservice) is requesting it.
* we could write code like this :  

```
    def _register_providers(self, requester, modules_to_import):
        for module in modules_to_import:
            if module.requester == requester:
                importlib.import_module(module)
```
