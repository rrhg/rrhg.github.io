
## Basic usage   
### Can context be used with Redux in the same React App ?
### Can we have many different contexts for different components in the same React App ?
### Why is recommended to set a default value when creating the context ?
### Why pass value in context.Provider if we already assigned a default?
### Why I couldn't get my current component context to works on it's own rendering components ?
### How does context help with drilling props ?


||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
||   
\/   




## Basic usage   
```   

//   context.js
export const ExaminationContext = React.createContext()
export class Provider extends React.Component {
...
    return (
        // is using props for value a bad idea for performance ?
        <ExaminationContext.Provider value={this.props.value}> // if keeping state in another component
                                    // value={initialValue}
            {this.props.children}
        </ExaminationContext.Provider>
  );
export const Consumer = ExaminationContext.Consumer; // for other type of use


  
//   parent.js
import { ExaminationContext, Provider, Consumer } from "./examination-context"
        const contextValue = { 
          somevar: "somevar",
          somemethod: somemethod,
        }
        ...
        return (
            //    context attributes available to children components
            <Provider value={contextValue}>  
              <Children>
              <GrandChildren>
              ...
            </Provider>



//   grandchildren.js
import { ExaminationContext, Provider, Consumer } from "./examination-context"
        const examinationContext = useContext(ExaminationContext)
          // usage
          examinationContext.somevar
          examinationContext.somemethod(arg1, arg2)
          ...
          
          
          // but in class components is used like this :
          static contextType = UserContext

          componentDidMount() {
              const user = this.context
              ...
```   


### Can context be used with Redux in the same React App ?
Yes   

### Can we have many different contexts for different components in the same React App ?
Yes. Context does NOT have to be global to the whole app, but can be applied to one part of your tree and you can (and probably should) have multiple logically separated contexts in your app.


### Why is recommended to set a default value when creating the context ?
Because we get better auto complete in the IDE (vs code). Functions cold be empty because the real function will be pass in value in context.Provider 


### Why pass value in context.Provider if we already assigned a default?
The defaultValue argument is only used when a component does not have a matching Provider above it in the tree. This can be helpful for testing components in isolation without wrapping them. Note: passing undefined as a Provider value does not cause consuming components to use defaultValue.
   
   
### Why I couldn't get my current component context to works on it's own rendering components ?
The provider always needs to exist as a wrapper around the parent element, no matter how you choose to consume the values. 
https://www.taniarascia.com/using-context-api-in-react/   

It's not about my element comunicating with it's children, a better description would be, that we need a grand parent that would keep a context & a state. 


### How does context help with drilling props ?
Example :
```
      <Questions isExam={isExam}
                 exam={exam}
                 headertitle="Examination"
                 addQuestionScore={addQuestionScore}
                 calculateTotalScore={calculateTotalScore}
                 totalScoreState={totalScoreState}
                 submitExamScores={submitExamScores}
                 setNote={setNote}
                 setExamNote={setExamNote}
                 setQuestionNote={setQuestionNote}
                 >
      </Questions>
 ```   
 And Questions component has many children, & we had to be passing props too many times. It was dificult to keep up.   
 Now, each child, that needs access to a context variable or method can just do :   
 ```
 import context ...
 const examinationContext = useContext(ExaminationContext)
 examinationContext.someMethod()
 ```
 
 
