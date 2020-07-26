
## implementing access control list in Django  
### as done by misago  

1. conf/middleware.py 
   1. creates `settings` property in `request`
   1. `request.settings = SimpleLazyObject(get_dynamic_settings)
   1.
   1.
1.
1.
1.
1.
1. a view (viewmodel) checks for permissions
   1. `if request.user.is_anonymous:`
   1.    `if list_type in LIST_DENIED_MESSAGES:`
   1.        `raise PermissionDenied(LIST_DENIED_MESSAGES[list_type])`
   1.    `else:`
   1.        `has_permission = request.user_acl["can_see_unapproved_content_lists"]`
   1.        `if list_type == "unapproved" and not has_permission:`
   1.             `raise PermissionDenied(`
   1.                 `_("You don't have permission to see unapproved content lists."))`
