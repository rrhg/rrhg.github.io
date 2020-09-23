
## DRF Serializers

1. What they do
   1. Validate data
   1. Convert database model instances to Python datatypes 
   1. Deserialization, allowing parsed data to be converted back into complex types, after first validating the incoming data.
   1. Deal with json, xml, csv 
   1. "Serializers are responsible for taking the user input, validating it and turning it into an object consumable by the database  :floppy_disk:. They also handle converting objects from the database into something that can be returned to the user. Additionally, a serializer also specifies which fields are required and what properties they have."
   1.
1. Why
   1. Keep code organized  :bowtie:
   1. Validation & conversion is done in one place
   1. Getting aditional data from request is easier 
      1. Instead of doing `name = request.data.get("name")`  
         1. For every attribute
         1. Validate each field
         1. Deal with python data types
            1. Like dict keys that sometimes have quotes & sometimes does not.
      1. You can pass a serializer to a viewset & let DRF do everything for you, 
         1. And if you need aditional data :
            1. You can do `validated_data.get('name')

1. What does **validate data** means :  
   1. After putting the data received in the fields it belongs, the data will be passed to [validators](https://www.django-rest-framework.org/api-guide/validators/)
   1. What does validators do ?
      1. If for example, a model field has a `unique=True` constrain, then the validator will make sure it is unique or raise an exception & posibly return a 400 Bad Request
   1. When validation is done ?
      1. When we call [serializer.isValid()](https://github.com/encode/django-rest-framework/blob/master/rest_framework/serializers.py#L215)
      1. isValid() calls other methods & at the end they pass the data to validators
      1. When deserializing data, you always need to call is_valid() before attempting to access the validated data, or save an object instance. If any validation errors occur, the .errors property will contain a dictionary representing the resulting error messages.
      1. 
   1. Does validation protects from SQL injection  :worried: ?
      1. No. 
      1. But that is done [here](https://docs.djangoproject.com/en/3.1/topics/security/#sql-injection-protection).
      1. " Django’s querysets are protected from SQL injection since their queries are constructed using query parameterization. A query’s SQL code is defined separately from the query’s parameters. Since parameters may be user-provided and therefore unsafe, they are escaped by the underlying database driver."
      1.
1. Why serializers have a save method
   1. `viewsets`  call `seralizer.save()` 
   1. `serializer.save()` calls 
   1. `self.create()` which calls
   1. `ModelClass._default_manager.create(validated_data)` & returns the `instance`
   1. This behavior in `create()` is the one that we can override in order to support **nested** & **multiple** object creations. See below.
   1. 
1. Creating & using serializers & viewset for **one instance at a time** is well explained in the [docs](https://www.django-rest-framework.org/api-guide/serializers/)
1. 
1. Dealing with **nested objects** is also [well explained](https://www.django-rest-framework.org/api-guide/serializers/#dealing-with-nested-objects)
   1. Notes :
      1. `validated_data` property will include nested data structures.
      1. If you're supporting writable nested representations you'll need to [write `.create()` or `.update()` methods that handle saving multiple objects](https://www.django-rest-framework.org/api-guide/serializers/#writing-create-methods-for-nested-representations).
      1.
      1. In my own words: when we nest a "child serializer" inside a "parent serializer", the "parent serializer" knows that the data coming in the request, will contain that aditional info (like a list or dict), & it will be correctly included in `validated_data' of the "parent serializer". 
         1. You may need to `pop()` this aditional data to create instances yourself
         1.
      1.
   1.
1. Dealing with **multiple objects** is [also explained](https://www.django-rest-framework.org/api-guide/serializers/#dealing-with-multiple-objects) but :
   1. Need to undertand [listserializer](https://www.django-rest-framework.org/api-guide/serializers/#listserializer)
   1. Important :
      1. Creating multiple instances may be more efficient using Django's [bulk_create](https://docs.djangoproject.com/en/3.0/ref/models/querysets/#bulk-create)
      1. [Here](https://medium.com/swlh/efficient-bulk-create-with-django-rest-framework-f73da6af7ddc) is an excellent blog & [Github repo](https://github.com/cdknorow/django_bulk_tutorial) on how to do that.
      1.
   1.
1. The [ModelSerializer](https://www.django-rest-framework.org/api-guide/serializers/#modelserializer) class provides a shortcut that lets you automatically create a Serializer class with fields that correspond to the Model fields.
   1. [Specifying-which-fields-to-include](https://www.django-rest-framework.org/api-guide/serializers/#specifying-which-fields-to-include)
1.
1. [overriding-serialization-and-deserialization-behavior](https://www.django-rest-framework.org/api-guide/serializers/#overriding-serialization-and-deserialization-behavior) 
   1. `to_internal_value` :  Takes the unvalidated incoming data as input and should return the validated data that will be made available as serializer.validated_data
   1. `to_representation` : from model instance to output 
   1. We can for example specify what data we need, & improve performa

9/01/2020
### ModelViewSet questions
   1. How to customize the behavior when retreiving details of just one DB item ?
      1. for example, when making a get request to mysite.com/api/mymodel/1/
      1. override retreive() method
   1. What does the self.get_object() method returns ?
      1. The instance of the Model from the queryset
      1. It can be used in the retreive(), list(), create(), etc.
   1. If we get `exam = self.get_object()` inside retreive() method ?
      1. Can we send it like this `return Response(exam)`
      1. No. Error object is not serializable
      1. We need to wrap it on a serilizer.
1. How use different serializers based on action ?
```   
class DualSerializerViewSet(viewsets.ModelViewSet):
    def get_serializer_class(self):
        if self.action == 'list':  # get request to /api/mymodels/
            return serializers.ListaGruppi
        if self.action == 'retrieve': # get request to /api/mymodels/id
            return serializers.DettaglioGruppi
        if self.action == 'create':   # post request to /api/mymodels/id
        return serializers.Default
 ```
How filter the global queryset for a ModelViewSet   
How get user   

```
    # queryset = Exam.objects.all()
    def get_queryset(self):
        user = self.request.user
        return Exam.objects.filter(users__in=str(user.id))
```   


## Serializers questions   
###How get current user in a serilizer method ?
   1. `user = self.context['request'].user`   
   
### With Django REST Framework, a standard ModelSerializer will allow ForeignKey model relationships to be assigned or changed by POSTing an ID as an Integer.

What's the simplest way to get this behavior out of a nested serializer?   
[https://stackoverflow.com/questions/29950956/drf-simple-foreign-key-assignment-with-nested-serializers](https://stackoverflow.com/questions/29950956/drf-simple-foreign-key-assignment-with-nested-serializers)   
```
from rest_framework import serializers


class RelatedFieldAlternative(serializers.PrimaryKeyRelatedField):
    def __init__(self, **kwargs):
        self.serializer = kwargs.pop('serializer', None)
        if self.serializer is not None and not issubclass(self.serializer, serializers.Serializer):
            raise TypeError('"serializer" is not a valid serializer class')

        super().__init__(**kwargs)

    def use_pk_only_optimization(self):
        return False if self.serializer else True

    def to_representation(self, instance):
        if self.serializer:
            return self.serializer(instance, context=self.context).data
        return super().to_representation(instance)
        
class ParentSerializer(ModelSerializer):
   child = RelatedFieldAlternative(queryset=Child.objects.all(), serializer=ChildSerializer)

    class Meta:
        model = Parent
        fields = '__all__'   
        
```   


### How customize what a serilizer field will return ?
### How filter the queryset for a child serializer to items where the current user is added to it's users ?   
```
class ExamDetailSerializer(serializers.ModelSerializer, MutableFields):
    questions = serializers.SerializerMethodField()
    class Meta:
        model = Exam
        fields = [
            "id",
            "title",
            "questions",
            ...
            ]
    def get_questions(self, instance):
        user = self.context['request'].user
        questions = instance.questions.filter(users__id=user.id)
        return QuestionSerializer(questions, many=True).data
```   

### How create get DB object, serialize it & send it, "on the fly" ?   
```
    @action(detail=True, methods=['get'], permission_classes = [AllowAny])
    def questionsdue(self, request, pk=None):
        #  ...
        # print('pk',pk)
        user = request.user
        qs = Exam.objects.filter(id=pk,users__id=user.id)
        # print('qs',qs.__dict__)        
        s = ExamSerializerForCreate(qs, many=True)
        # s = ExamDetailSerializer(qs) # need many=True
        # s.is_valid() # not needed. not sure why
        return Response({'data': s.data})

```   







### How & why include context ?
### why serializing the following queryset needs many=True ?   
### why the error is misleading ?

        `qs = Exam.objects.filter(id=pk,users__id=user.id)`   
        
```
serializer = MessageSerializer(qs, many=True, context={'request': request})

# needs many=True because even if it is only going to receive 1 object (id=pk), since we are filtering(users__id=user.id), the serializers thinks we can receive a list, & somewhere down the pipeline, someone is expecting a list.

# need to pass context because I was instantiating the serializer myself & returning the Reaponse with serializer.data.  Normally, we don't do that, instead we give the viewSet a seriliazer, & let the vieSet instantiate the serializer. In that case the viewSet takes care of passing the context.

But the error msg is misleading, because instead of saying that someone was expecting a list, or soemething related, yhe mag says that the queryset has no attribute ...(like id, or any other attribute   

```

### How model serializer deals with relationship field ?    

Any relationships such as foreign keys on the model will be mapped to PrimaryKeyRelatedField. Reverse relationships are not included by default unless explicitly included as specified in the serializer relations documentation.

---





