
## DRF Serializers

1. What they do
   1. Validate data
   1. Convert model instances to Python datatypes 
   1. Deserialization, allowing parsed data to be converted back into complex types, after first validating the incoming data.
   1.
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
      1. When we call [data.isValid()](https://github.com/encode/django-rest-framework/blob/master/rest_framework/serializers.py#L215)
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
1. 

