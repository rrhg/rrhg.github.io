Some code snippets for office-script aka excel online javascript scripts :   

```

    // Format the range to display numerical dollar amounts.
    selectedSheet.getRange("D2:E8").setNumberFormat("$#,##0.00");

    // Fit the width of all the used columns to the data.
    selectedSheet.getUsedRange().getFormat().autofitColumns();   
    
    function main(workbook: ExcelScript.Workbook) {
    workbook.refreshAllDataConnections()
    }

    // taking data from a column & inserting in a row
    let data = sheet.getRange("B6:B12").getValues() // from acolumn
    // * for setValues(), data has to be in a sub arrays
    // * format for multiple values= [ [array for each row] ] 
    let dataForRow = [data.map(arr=>arr[0])] // for inserting in a row
    const rowRange = sheet.getRange("B5:H5")
    rowRange.setValues(dataForRow)
   

function getEmpTotalSalaryInSheet(sheet: ExcelScript.Worksheet, empName) {
  const found = findValueRangeInSheet(sheet, empName)
  if (found) {
    const the7thCellToTheRight = found.getOffsetRange(0,7).getValues()[0][0]
    console.log(the7thCellToTheRight ) 
  }
}


function findValueRangeInSheet(sheet:ExcelScript.Worksheet, empName) {
  const range = sheet.getUsedRange()
  // range.find was undefined before adding :ExcelScript.WorkSheet
  let found = range.find(empName, {
    completeMatch: true,
    matchCase: false,
    //searchDirection: Excel.SearchDirection.forward,
  })
  return found
  // if(found){console.log(found.getAddress())}
} // end of getEmpTotalSalaryInSheet

...


```
