
## DRF Serializers

1. what they do
   1. validate data
   1. convert model instances to Python datatypes 
   1. deserialization, allowing parsed data to be converted back into complex types, after first validating the incoming data.
   1.
   1. "Serializers are responsible for taking the user input, validating it and turning it into an object consumable by the database  :floppy_disk:. They also handle converting objects from the database into something that can be returned to the user. Additionally, a serializer also specifies which fields are required and what properties they have."
   1.
1. why
   1. keep code organized  :bowtie:
   1. validation & conversion is done in one place
   1.

1. what does **validate data** means :  
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
      1. But hat is done [here](https://docs.djangoproject.com/en/3.1/topics/security/#sql-injection-protection).
      1. " Django’s querysets are protected from SQL injection since their queries are constructed using query parameterization. A query’s SQL code is defined separately from the query’s parameters. Since parameters may be user-provided and therefore unsafe, they are escaped by the underlying database driver."
      1.
1. why they have a save method
   1. `save()` calls 
   1. `self.create()` which calls
   1. `ModelClass._default_manager.create(validated_data)` & returns the `instance`
   1.
1. should we write validators for everything
