
## Implementing ACL (access control lists) for permissions in Django  
### as done by misago  

1. The basic idea
   1. We define permissions 
   1. Middleware get permissions for each request
   1. Views check for permissions 
   1. Response only includes the content allowed for this user
   
Now let's start breaking it down in more detailed steps  
1. Defining Permissions
   1. Each Django app have it's own ACL (access control lists of permissions)
   1. Permissions can be for :
      1. Models
      1. Templates
      1. Views
1. Middleware add permissions to the request object
   1. Get the user for this request
   1. Get permissions for this user
   1. Add those permissions to the request object
   1.
   1.
1. Views check for permissions
   1. Permissions can be checked for :
      1. View
      1. Models
      1. Other objects
   1. 
1. Response only includes the content allowed for this user
   1. request can be redirected
   1. Queries are filtered
   1. Template tags 
   1.
   1.  
   
   
1. Each app has it's own permissions in permissions.py
1.
1. acl/useracl.py in get_user_acl
   1. uses `acl/buildacl.py` to build `user_acl` dict
   1. add these other properties to `user_acl`
      1. user_id
      1. is_authenticated
      1. is_anonymous
      1. is_staff
      1. is_superuser
      1. cache_versions
1.
1. user_acl_middleware
   1. set user_acl property on the request.
   1. This user_acl property is plain dictionary that contains user acl as well as additional data useful for permission checks:
   1. 
   1. 
   1. 
1. conf/middleware.py 
   1. creates `settings` property in `request`
   1. `request.settings = SimpleLazyObject(get_dynamic_settings)
   1.
   1.
1.
1.
1. views can check for permissions by :
   1. `if not request.user_acl["can_see_these_items"]:  
           raise PermissionDenied("You can't see these items")`
   1.
1. views have methods that check request user acls & modify the queryset to not include results that should not be shown.
1. v
1. a view (viewmodel) checks for permissions
   1. `if request.user.is_anonymous:`
   1.    `if list_type in LIST_DENIED_MESSAGES:`
   1.        `raise PermissionDenied(LIST_DENIED_MESSAGES[list_type])`
   1.    `else:`
   1.        `has_permission = request.user_acl["can_see_unapproved_content_lists"]`
   1.        `if list_type == "unapproved" and not has_permission:`
   1.             `raise PermissionDenied(`
   1.                 `_("You don't have permission to see unapproved content lists."))`
