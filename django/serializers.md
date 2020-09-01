
## Serializers

1. what they do

1. why

1. what does validate data means :  
   1. After putting the data received in the fields it belongs, the data will be passed to [validators](https://www.django-rest-framework.org/api-guide/validators/)
   1. What does validators do ?
      1. If for example, a model field has a `unique=True` constrain, then the validator will make sure it is unique or will trow an error
   1. When validation is done ?
      1. When we call [data.isValid()](https://github.com/encode/django-rest-framework/blob/master/rest_framework/serializers.py#L215)
      1. isValid() calls other methods & at the end they pass the data to validators
1. why they have a save method

1. should we write validators for everything
