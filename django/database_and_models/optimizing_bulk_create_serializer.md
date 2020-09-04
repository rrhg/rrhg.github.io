
## Using Django `model.objects.bulk_create()` in DRF Serializers to optimize de creation of large amounts of model instances

[Getting a better understanding about DRF Serializers](https://github.com/rrhg/rrhg.github.io/blob/master/django/drf_serializers.md), & researching about creation of large amount of database models, I found out about [https://github.com/cdknorow/django_bulk_tutorial](https://github.com/cdknorow/django_bulk_tutorial).

Here is how I was able to implement my version of bulk create in a DRF Serializer.

```
class QuestionScore_BulkCreateListSerializer(serializers.ListSerializer):
    def create(self, validated_data):

        # list of questionscore instances that have NOT been saved to the database
        result = [self.child.create(attrs) for attrs in validated_data]

        try:
            self.child.Meta.model.objects.bulk_create(result)
        except IntegrityError as e:
            raise ValidationError(e)
        return result


class QuestionScore_BulkCreateSerializer(serializers.ModelSerializer):
    def create(self, validated_data):
        instance = QuestionScore(**validated_data)

        #    if is a single object creation ( not multiple)
        #    save it. We won't be using list_serializer_class
        if isinstance(self._kwargs["data"], dict):
            instance.save()

        return instance

    class Meta:
        model = QuestionScore
        fields = ("amount", "question", "notes")

        # if the view instantiating this serializer pass many=True
        # then this serializer will be a child of list_serializer_class
        list_serializer_class =  QuestionScore_BulkCreateListSerializer
        
```
