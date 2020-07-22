
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



-----------------
