
## How misago uses django-mttp to improve performance in terms of amount of database queries  

### high level idea  
1. `category` is a django-mttp MPTTModel
1. users can create `category` children, grand children, an so on.
1. for each `category` model
   1. mttp created a tree of nodes in the database
   1. each tree has a top level(0) node 
   1. top level node has an id
   1. that id will be stored in category__tree_id


### How to keep data ordered  
```
class Genre(MPTTModel):
    name = models.CharField(max_length=50, unique=True)
    parent = TreeForeignKey('self', on_delete=models.CASCADE, null=True, blank=True, related_name='children')

    class MPTTMeta:
        order_insertion_by = ['name']
```  

### Why in misago when querying `MyMPttModel.objects.filter(level=0, special_role=specialrole)` we always get the same node ?  
Because Misago does not assign the Meta class property `order_insertion_by`. 
The first MyMPttModel created (for that special role like `private`) will always be level=0.  


### When getting categories, in adition to have id of top level(o) node, we also need the type :
* for a field named `special_role`
* they're just a strings, defined in misago/categories/__init__.py
  * PRIVATE_THREADS_ROOT_NAME = "private_threads"
  * THREADS_ROOT_NAME = "root_category"
* and I added these 2
  * PRIVATE_QAS_ROOT_NAME = "private_qas"
  * QAS_ROOT_NAME = "qa_root_category"
* I think only the level nodes have a `special_role` field because when querying for the a root node, we use the `get` method. See note 1.


Note 1  
```
def get_special(self, special_role):
        cache_name = "%s_%s" % (CACHE_NAME, special_role)

        special_category = cache.get(cache_name, "nada")
        if special_category == "nada":
