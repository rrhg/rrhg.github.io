
## How misago uses django-mttp to improve performance in terms of amount of database queries  

### high level idea  
1. `category` is a django model
1. users can create `category` children, grand children, an so on.
1. for each `category` model
   1. mttp created a tree of nodes in the database
   1. each tree has a top level(0) node 
   1. top level node has an id
   1. that id will be stored in category__tree_id



### When getting categories, in adition ti have id of top level(o) node, we also need the type( a field named `special_role`) which is just a string. there's 2 options :
* PRIVATE_QAS_ROOT_NAME
* QAS_ROOT_NAME  



-----------------
