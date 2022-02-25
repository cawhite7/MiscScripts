$updateid = Import-Csv C:\Users\cwhite\Desktop\Users.csv

Write-Output 'Account,EmployeeID' >> C:\Users\cwhite\Desktop\EnterEmployeeID.txt

foreach ($user in $updateid){

    $samaccount = $user.SamAccountName
    $employeeident = $user.Employeeident

    Set-ADUser $samaccount -Description $employeeident

    Write-Output "$samaccount $employeeident" >> C:\Users\cwhite\Desktop\EnterEmployeeID.txt

    }