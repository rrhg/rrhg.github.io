
An exanple of how to use **React router params ** & `array.find()` to get a specific object from a list   

## in react router :   
```
let routes = [
...
{
  path: '/exams/examination/:id',
  component: Examination
},
...
]
```   

```
 const linkToExamination = "/exams/examination/"+exam.id
  ...  
  <Link to={linkToExamination}>
        Take this examination now
   </Link>   
```



> Note: router params are pass as a string, but if the id is a number, thats what `find()` will return. So we have to use `String()`.
```
export default function Detail(props) {
    const exams = props.exams
    const ids = exams.map( e => e.id)
    const exam = exams.find( e => String(e.id) === props.params.id)
```
