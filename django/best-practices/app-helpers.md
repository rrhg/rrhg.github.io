

As I was reading Daniel Feldroy's book "**Two Scoops of Django 3.x, Best Practices for the Django Web Framework**", in chapter 4 "Fundamentals of Django App Design", their argument about a helpers.py file was very compelling to me.  

> helpers.py What we call helper functions. These are where we put code extracted from views (Section 8.5: Try to Keep Business Logic Out of Views) and models (Sec- tion 6.7: Understanding Fat Models) to make them lighter. Synonymous with utils.py.   


<p>I find misago models, viewmodels, & views too complicated. That prompts me the idea to get some of the code out of those & put it in a helpers.py file.  Not in misago code, but in the Django apps I added to the project:</P>   
1. questions
1. apps   

As an example, take a look at <a href="#">mte/misago/questions/models/question.py<a> & <a href="#">mte/misago/questions/helpers.py<a>. I took some of the code out of Question model & put it in helper.py.  The code extratced was substituted with functions with long names that describe what the code does.





