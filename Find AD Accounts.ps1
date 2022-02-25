$csv = Import-Csv C:\Users\cwhite\Desktop\HRreport.csv

$output = "C:\Users\cwhite\Desktop\NoUserFound.csv"

$c = 0
$count = $csv.Count

$d = 0

Write-Output "" | Export-Csv $output
Start-Sleep -Seconds 2
Write-Output "First,Middle,Last,ID,Status,Position,Department" >> $output

foreach ($user in $csv) {
    
    $first = $user.First
    $middle = $user.Middle
    $last = $user.Last
    $ID = $user.ID
    $status = $user.Status
    $position = $user.Position
    $department = $user.Department

    $error.Clear()

    $getUser = Get-ADUser -Filter "Description -eq $ID"

    if ($getUser -eq $null) {
            Write-Output "$first,$middle,$last,$ID,$status,$position,$department" >> $output
            } else {
            $d++
            }

    [console]::WriteLine("$c of $count")
    $c++
}

$d >> C:\Users\cwhite\Desktop\FoundNumbers.txt