### Here is how I did a :
* ManyToMany Relantionship
* between Questions & Tags models
* using an intermediary model named Tagged
* and the through argument  


```
class Question(models.Model):
...

class Tag(models.Model):
    questions = models.ManyToManyField(
        Question,
        through='Tagged',
        )

class Tagged(models.Model):
    question = models.ForeignKey(
        Question,
        on_delete=models.CASCADE,
        )
    tag = models.ForeignKey(
        Tag,
        on_delete=models.CASCADE,
        )
    tagged_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        blank=True,
        null=True,
        on_delete=models.SET_NULL,
        related_name="+",
    )
        
        
```  

One way to create could be :  
```
            tagged = Tagged(
                question=question,
                tag=tag,
                tagged_by=starter,
                )
            tagged.save()  
```  
