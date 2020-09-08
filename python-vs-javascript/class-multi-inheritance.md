

python `class Myclass(Parent1, Parent2):`   
js ` not so easy :(`   
   [https://javascript.info/mixins](https://javascript.info/mixins)   
   [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Details_of_the_Object_Model](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Details_of_the_Object_Model)   
   [https://stackoverflow.com/questions/29879267/es6-class-multiple-inheritance](https://stackoverflow.com/questions/29879267/es6-class-multiple-inheritance)

### Python: How does Method Resolution Order affects inheritance & what methods are called ?   
`class child(Parent1, Parent2) : ` will look first for a method in Parent1, if doesn't find it, then looks in Parent2

### How can we make the child call the method of both parents ?   
By calling super(Parent1, self).method from the Parent1 method

