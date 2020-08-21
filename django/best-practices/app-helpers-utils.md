

As I was reading Daniel Feldroy's book "**Two Scoops of Django 3.x, Best Practices for the Django Web Framework**", in chapter 4 "Fundamentals of Django App Design", their argument about a helpers.py file was very compelling to me.  

> helpers.py What we call helper functions. These are where we put code extracted from views (Section 8.5: Try to Keep Business Logic Out of Views) and models (Sec- tion 6.7: Understanding Fat Models) to make them lighter. Synonymous with utils.py.   

Misago has the same concept, but the file is called utils.py.  

So to practice this concept, in the next django app I was going to create, which is named [exams](#), decided to get some of the code out of models & views, and put it in a [utils.py](#) file.  I would had prefer to call it helpers.py but since other apps in the [project](#) use utils.py, decided to keep the consistency.





