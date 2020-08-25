
### What is a database index ?  
Indexes are special lookup tables that the database search engine can use to speed up data retrieval.

### An example of defining an index in Django: (from [Misago project](https://github.com/rafalp/Misago))
```
class Post(models.Model):
    ...
    ...
    class Meta:
        indexes = [
            models.Index(
                name="misago_post_has_open_repo_part",
                fields=["has_open_reports"],
                condition=Q(has_open_reports=True),
            ),
            models.Index(
                name="misago_post_is_hidden_part",
                fields=["is_hidden"],
                condition=Q(is_hidden=False),
            ),
            models.Index(
                name="misago_post_is_event_part",
                fields=["is_event", "event_type"],
                condition=Q(is_event=True),
            ),
            GinIndex(fields=["search_vector"]),
        ]

        index_together = [
            ("thread", "id"),  # speed up threadview for team members
            ("is_event", "is_hidden"),
            ("poster", "posted_on"),
        ]
```
  
### One example of when will this be useful ?  
```
MyModel.objects.filter(has_open_reports=True)
```  
  
  
  
### An idea of how index_together works according to [this stackoverflow question](https://stackoverflow.com/questions/21753699/does-the-order-of-index-together-matter-in-a-django-model) :  

The order of index_together explains the "path" the index is created. You can query from left to the right to profit from the index.
