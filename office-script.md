Some code snippets for office-script aka excel online javascript scripts :   

```

    // Format the range to display numerical dollar amounts.
    selectedSheet.getRange("D2:E8").setNumberFormat("$#,##0.00");

    // Fit the width of all the used columns to the data.
    selectedSheet.getUsedRange().getFormat().autofitColumns();   
    
    function main(workbook: ExcelScript.Workbook) {
    workbook.refreshAllDataConnections()
}


```
