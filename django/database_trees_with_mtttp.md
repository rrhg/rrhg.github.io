
## How misago uses django-mttp to improve performance in terms of amount of database queries  

### high level idea  
1. `category` is a django model
1. users can create `category` children, grand children, an so on.
1. for each `category` model
   1. mttp created a tree of nodes in the database
   1. each tree has a top level(0) node 
   1. top level node has an id
   1. that id will be stored in category__tree_id



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
```    def get_special(self, special_role):
        cache_name = "%s_%s" % (CACHE_NAME, special_role)

        special_category = cache.get(cache_name, "nada")
        if special_category == "nada":
            # simply get the category with this special_role
            # get is when only u are sure only one exist
            # no results will raise a DoesNotExist exception.
            # if more than one item matches it will raise MultipleObjectsReturned, 
            # which again is an attribute of the model class itself.
            special_category = self.get(special_role=special_role)
            cache.set(cache_name, special_category)
        return special_category
```

-----------------
