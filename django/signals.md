
### Django Signals (basic idea)


mysignal = django.distpacth.Signal(args=xxx)


misygnal.send(args)


import mysignal  
mysignal.connect(my_callback)


or : (there are 2 ways)


@receiver(mysignal)  
def my_callback(sender, **kwargs):  
    do something

------------------------------------------------------------------
signals are called synchronously; in other words, the normal program execution flow runs each receiver in turn before continuing with the code that sent the signal.
-----------------------------------------------------------------
> Only use signals to avoid introducing circular dependencies.
If you have two apps, and one app wants to trigger behaviour in an app it already knows about, don’t use signals. The app should just import the function it needs and call it directly.

Signals come into play if the reverse is needed: you want an app to trigger behaviour in an app that depends upon that app. In this case, signals are a great way of providing a ‘hook’ which the second app can exploit by connecting a receiver to it.
-------------------------------------------------------------------

You must ensure the receiver code is imported when the project is bootstrapped. I think the clearest place for this is in a receivers.py module, which can be imported inside the ready() method of the application configuration class.

If you follow this convention throughout your project, you may prefer to use module autodiscovery in a single app, which will mean the receivers.py module in every installed app will be imported:

#### main/__init__.py
from django.apps import AppConfig as BaseAppConfig
from django.utils.module_loading import autodiscover_modules


class AppConfig(BaseAppConfig):
    name = 'main'

    def ready(self):
        # Automatically import all receivers files
        autodiscover_modules('receivers')


default_app_config = 'main.AppConfig'

-------------------------------------------------------------
https://seddonym.me/2018/05/04/django-signals/
