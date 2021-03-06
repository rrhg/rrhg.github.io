
### From `yarn lint` to `eslint` to `babel` to `jsx-ast-utils`   

A discovery journey about npm dependencies, ASTs, parsers & the likes...   

> it turns out, the argument received is something called an AST... Wait what ???   :confused:   


So, my firsts 2 accepted & merged Pull Requests were with the library `jsx-ast-utils`.  Here is a summary of how it works, how it is used, but more important, why you may have never heard of it even when it is used on every project where eslint & react are used together.   


---   
### Using Reactjs.org as an example   
It all started with this [issue]().  The problem really was on `jsx-ast-utils`, which is a dependency of `eslint-plugin-react` which is a dependency `Reacjs.org`.  Easy right ? Piece of cake :cake: **What could posibly go wrong ?**   

###  yarn lint   
The issue could be reproduced by cloning `Reactjs.org`, & running `yarn` & `yarn lint`.
If take a look at package.json we can see what it does :   
1. `"scipts": { "lint": "eslint .", ...`   
   1. Oh, that's easy, we are calling `eslint`.  :ballot_box_with_check:   


### eslint   
If we look in `.eslinrc` (eslint config file) we see :   
1. `"plugins": ["react", ...`
   1. Oh cool, is using `eslint-plugin-react` 
   1. This helps eslint deal with React instead of just javascript  :ballot_box_with_check:
1. `"parser": "babel-eslint"`
   1. `eslint` doesn't magically knows how to read javascript, it use a parser that takes javascript as input & outputs something `eslint` can understand   :ballot_box_with_check:
   1. That way `eslint` can see that you made a mistake.
   1. The work performed by this parser is what **caught me off guard**  :open_mouth: , but I'll explain that a few setps below...   
   
### eslint-plugin-react   
1. To learn more about eslint plugins see : https://eslint.org/docs/developer-guide/working-with-plugins   
1. But looking at the [plugin code](https://github.com/yannickcr/eslint-plugin-react/blob/master/index.js), I think it is simpler than it looks.
   1. Basically is a set of rules added to eslint. 
   1. Each rule is a function, that will :
      1. Receive code from the parser(recieves ATS, but more on this below)
      2. Use `jsx-ast-utils` & other helpers to make sense of the code
      3. Make reports if it find something wrong
      4. Of course it's more complicated than that, but we get the idea
1. This plugin helps eslint deal with React instead of just javascript. 
   1. For example, in vanilla javascript, there is no jsx.   
   
### jsx-ast-utils   
But how does `eslint-plugin-react` uses `jsx-ast-utils` ?   
Here's an example :   
```
     const elementType = require('jsx-ast-utils/elementType')
   
     function isDOMComponent(node) {
       const name = elementType(node);
       return COMPAT_TAG_REGEX.test(name);
     }
```   
In this example, `jsx-ast-utils` is been used to find the type of an ATS node.   

> it turns out, the argument received is something called an AST... Wait what ???   :confused:   

### But what is an ATS node  ?   
Remember when I said "a parser that takes javascript as input & outputs something `eslint` can understand" ?   
Well, here's the thing, the output of the parser is something called AST (Abstract Syntax Tree). I think of it as a tree(**kind of a giant json object**) representation of your code.   
For a better explanation about TSA see : https://medium.com/basecs/leveling-up-ones-parsing-game-with-asts-d7a6fc2400ff   


### But how does babel do that ?   
Explaining that is way over my head, but researching about the topic, I found this really good explanation of how to write a plugin for the babel parser  [https://lihautan.com/step-by-step-guide-for-writing-a-babel-transformation/]   
It's so good that it made things 'click' for me, & here's the basic example that did that :   
```
import { parse } from '@babel/parser';
import traverse from '@babel/traverse';
import generate from '@babel/generator';

const code = 'const n = 1';

// parse the code -> ast
const ast = parse(code);

// transform the ast
traverse(ast, {
  enter(path) {
    // in this example change all the variable `n` to `x`
    if (path.isIdentifier({ name: 'n' })) {
      path.node.name = 'x';
    }
  },
});

// generate code <- ast
const output = generate(ast, code);
console.log(output.code); // 'const x = 1;'
```   

### But how is that related to eslint   
1. A babel plugin 
   1. Takes AST from babel/parser
   1. Transform the AST using babel/traverse
   1. Pass AST to babel/generator to be converted back to code   
    
1. `eslint`
   1. Takes AST from babel/parser
   1. Use rules(functions) to read AST & report errors & deviations from the rules.
   1. I still need to figure out how does it fix code
 


