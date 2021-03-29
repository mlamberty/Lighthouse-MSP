 
  #Get CSVs
$files = Get-ChildItem -Path C:\Users\matthewl\Documents\ -File *.csv
$S =$files.count

Write-Host "Detected the following CSV files: ($S)"
foreach ($csv in $files) {
    Write-Host " -"$csv.Name
}
#OUtput file
$xls = "C:\Users\matthewl\Downloads\Azure\coa.xlsx"
Write-Host "Creating: $xls"

foreach ($csv in $files) {
    $csvPath = "C:\Users\matthewl\Documents\" + $csv.Name
    $worksheetName = $csv.Name.Replace(".csv","")
    Write-Host " - Adding $worksheetName to $xls"
    Import-Csv -Path $csvPath | Export-Excel -Path $xls  -WorkSheetname $worksheetName}