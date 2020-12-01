Some code snippets for office-script aka excel online javascript scripts :   

```   


    // get the intersection cell range of an employee row & a table column
    // 0 indexed
    const columnIndex = INPUT_TABLE.getColumnByName(SALARY_COLUMN).getIndex()
    // 0 indexed
    const empRowIndex = findValueRangeInSheet(INPUTSHEET, String(e.name)).getRowIndex()

    const cellRange = INPUTSHEET.getRangeByIndexes(empRowIndex, columnIndex, 1, 1)

    console.log(cellRange.getAddress())




    //    save named items  (data that persist)
    let mynamedItem = workbook.getNamedItem("quincenaPrevia2")
    mynamedItem.delete()
    workbook.addNamedItem("quincenaPrevia2", "Ene")
    mynamedItem = workbook.getNamedItem("quincenaPrevia2")
    console.log(mynamedItem.getValue())
    mynamedItem.delete()
    workbook.addNamedItem("quincenaPrevia2", "Feb")
    console.log(mynamedItem.getValue())



    //    Format the range to display numerical dollar amounts.
    selectedSheet.getRange("D2:E8").setNumberFormat("$#,##0.00");

    //    Fit the width of all the used columns to the data.
    selectedSheet.getUsedRange().getFormat().autofitColumns();   
    
    function main(workbook: ExcelScript.Workbook) {
    workbook.refreshAllDataConnections()
    }

    //    taking data from a column & inserting in a row
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
  
  // another way for search for strings
  //  range.getAll(text,criteria) // find all ocurrences of a string

  
  // range.find was undefined before adding :ExcelScript.WorkSheet
  let found = range.find(empName, {
    completeMatch: true,
    matchCase: false,
    //searchDirection: Excel.SearchDirection.forward,
  })
  return found
  // if(found){console.log(found.getAddress())}
} // end of getEmpTotalSalaryInSheet



// reconstruct a table totals row when copying just values from another table, but still want to be able to get totals by table name/column/totals
    const table = sheet.getTable("Table814")
    const lastRowValues = table.getRange().getLastRow().getValues()
    let index = table.getRowCount()
    table.deleteRowsAt(Number(index-1))
    table.setShowTotals(true)
    table.getTotalRowRange().setValues(lastRowValues)
    table.getTotalRowRange().getFormat().setHorizontalAlignment(ExcelScript.HorizontalAlignment.right)


  // find specific range in table 
  //    - based on a string in row
  //    - and a column by name
    let firstEmployeeRow = findValueRangeInTable(outTable, "1").getEntireRow()
  console.log('index = ' + firstEmployeeRow.getRowIndex())
  console.log('firstEmployeeRow = ' + firstEmployeeRow.getAddress())
    let firstColumnWithData = outTable.getColumn(REG_HOURS_COLUMN).getRange()
  console.log('firstColumnWithData = ' + firstColumnWithData.getAddress() )
    let firstCellWithData = firstEmployeeRow.getIntersection(firstColumnWithData)

  console.log('firstCellWithData = ' + firstCellWithData.getAddress())

    let lastCellWithData = outTable.getColumn("Salario-Neto").getRange().getLastRow()

    let allCellsWithData = sheet.getRange(firstCellWithData.getAddress()+ ":" + lastCellWithData.getAddress() )

  // // outTable.getRangeBetweenHeaderAndTotal().getResizedRange(0,) getRange()
  
    allCellsWithData.setNumberFormatLocal(
     "_(* #,##0.00_);_(* (#,##0.00);_(* \"-\"??_);_(@_)"
    );






...


```
