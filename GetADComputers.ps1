


Import-Module ActiveDirectory


$tableName = "ADComputers > 90days"

$table = New-Object system.Data.DataTable "$tableName"

$col1 = New-Object System.Data.DataColumn Name,([string])
$col2 = New-Object System.Data.DataColumn LastLogon,([string])
$col3 = New-Object System.Data.DataColumn DNSHostName,([string])
$col4 = New-Object System.Data.DataColumn Enabled,([string])
$col5 = New-Object System.Data.DataColumn OperatingSystem,([string])
$col6 = New-Object System.Data.DataColumn CanonicalName,([string])

$table.Columns.Add($col1)
$table.Columns.Add($col2)
$table.Columns.Add($col3)
$table.Columns.Add($col4)
$table.Columns.Add($col5)
$table.Columns.Add($col6)


$ADComputers = Get-ADComputer -Filter * -Properties Name,LastLogon,DNSHostName,Enabled,OperatingSystem,CanonicalName

foreach ($ADC in $ADComputers) {


$row = $table.NewRow()

$row.Name = $ADC.Name
$row.LastLogon = [datetime]::FromFileTime($ADC.LastLogon).ToString('MM/dd/yyyy')
$row.DNSHostName = $ADC.DNSHostName
$row.Enabled = $ADC.Enabled
$row.OperatingSystem = $ADC.OperatingSystem
$row.CanonicalName = $ADC.CanonicalName

$table.Rows.Add($row)

}

$table | Export-Csv C:\Users\cwhite\Desktop\ADComputers.csv -NoTypeInformation