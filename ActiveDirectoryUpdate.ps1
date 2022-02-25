$error.clear()

$i = 0
$continue = ""
while ($continue -notmatch "[y|n]")
    {
    $continue = Read-Host "Do you want to make changes to Active Directory Users? (Yes or No)"
    }

$lastNameChangePath = "$($env:USERPROFILE)\Desktop\AD Update\LastNameChange.csv"
$foundEmployeesADPath = "$($env:USERPROFILE)\Desktop\AD Update\FoundEmployeesAD.txt"
$NewLastNamePath = "$($env:USERPROFILE)\Desktop\AD Update\NewLastname.txt"
$NotFoundEmployeesADPath = "$($env:USERPROFILE)\Desktop\AD Update\NotFoundEmployeesAD.txt"


if ($continue -eq "Yes")
    {

    function SleepProgress([hashtable]$SleepHash){
     [int]$SleepSeconds = 0
     foreach($Key in $SleepHash.Keys){
         switch($Key){
             "Seconds" {
                 $SleepSeconds = $SleepSeconds + $SleepHash.Get_Item($Key)
             }
             "Minutes" {
                 $SleepSeconds = $SleepSeconds + ($SleepHash.Get_Item($Key) * 60)
             }
             "Hours" {
                 $SleepSeconds = $SleepSeconds + ($SleepHash.Get_Item($Key) * 60 * 60)
             }
         }
     }
     for($Count=0;$Count -lt $SleepSeconds;$Count++){
         $SleepSecondsString = [convert]::ToString($SleepSeconds)
         Write-Progress -Activity "Please wait for $SleepSecondsString seconds" -Status "Starting ActiveDirectory Update...     CTRL+C at any time to cancel" -PercentComplete ($Count/$SleepSeconds*100)
         Start-Sleep -Seconds 1
     }
     Write-Progress -Activity "Please wait for $SleepSecondsString seconds" -Completed
     }
        $SleepTime = @{"Seconds" = 5;"Minutes" = 0}
        SleepProgress $SleepTime



Import-Module ActiveDirectory

$users = Import-Csv "$($env:USERPROFILE)\Desktop\AD Update\AD Update.csv"

Write-Output "Employeeident,Firstname,Lastname" >> $lastNameChangePath

    ForEach ($user in $users)
        {

            $givenname = $user.Firstname
            $surname = $user.Lastname
            $department = $user.Department
            $position = $user.Position
            $employeeident = $user.Employeeident
            $fullname = "$givenname "+"$(Get-ADUser -Filter "Description -eq $employeeident" -Properties Initials | foreach { $_.Initials })."+" $surname"
            $fullname2 = "$givenname"+" $surname"
            $middleinitial = Get-ADUser -Filter "Description -eq $employeeident" -Properties Initials | foreach { $_.Initials }
            $oldlastname = Get-ADUser -Filter "Description -eq $employeeident" -Properties Surname | foreach { $_.Surname }
            $csv2ad = Get-ADUser -Filter "Description -eq $employeeident"

    if ($csv2ad -and $oldlastname -ne $surname)
        {
        Write-Output "$employeeident,$givenname,$oldlastname" >> $lastNameChangePath
        }

    if ($csv2ad)
        {
        $csv2ad | Set-ADUser -GivenName $givenname -Surname $surname -DisplayName $fullname2
        $csv2ad | Rename-ADObject -NewName $fullname2
        Write-Output "Success EmployeeID $employeeident, $givenname $surname" >> $foundEmployeesADPath
        }
    else
        {
        Write-Output "EmployeeID $employeeident, $givenname $surname NOT FOUND" >> $NotFoundEmployeesADPath
        }

           if ("$middleinitial" -ne $null -and "$middleinitial" -ne ''){
Get-ADUser -Filter "Description -eq $employeeident" | Rename-ADObject -NewName $fullname
        }

           $i++
   Write-Progress -activity "Scanning CSV" -status "Scanned: $i of $($Users.Count)" -percentComplete (($i / $Users.Count)  * 100)
}
# END OF FOREACH




function SleepProgress([hashtable]$SleepHash){
     [int]$SleepSeconds = 0
     foreach($Key in $SleepHash.Keys){
         switch($Key){
             "Seconds" {
                 $SleepSeconds = $SleepSeconds + $SleepHash.Get_Item($Key)
             }
             "Minutes" {
                 $SleepSeconds = $SleepSeconds + ($SleepHash.Get_Item($Key) * 60)
             }
             "Hours" {
                 $SleepSeconds = $SleepSeconds + ($SleepHash.Get_Item($Key) * 60 * 60)
             }
         }
     }
     for($Count=0;$Count -lt $SleepSeconds;$Count++){
         $SleepSecondsString = [convert]::ToString($SleepSeconds)
         Write-Progress -Activity "Please wait for $SleepSecondsString seconds" -Status "Processing..." -PercentComplete ($Count/$SleepSeconds*100)
         Start-Sleep -Seconds 1
     }
     Write-Progress -Activity "Please wait for $SleepSecondsString seconds" -Completed
     }
        $SleepTime = @{"Seconds" = 10;"Minutes" = 0}
        SleepProgress $SleepTime




$namechanges = Import-Csv $lastNameChangePath

    ForEach ($namechange in $namechanges)
        {

            $employeeidentification = $namechange.Employeeident
            $newlastname = Get-ADUser -Filter "Description -eq $employeeidentification" -Properties Surname | foreach { $_.Surname }
            $oldlastnamefile = $namechange.Lastname
            $Firstname = $namechange.Firstname

    Write-Output "User $Firstname $oldlastnamefile changed to $Firstname $newlastname" >> $NewLastNamePath
}
# END OF FOREACH

Write-Host "`
        Script completed       " -BackgroundColor Green
Write-Host "  Number of errors occured = $($error.Count) " -BackgroundColor Red

}

else
       {
       Write-Host "`
       Script cancelled        " -BackgroundColor Red

       Write-Host "  Number of errors occured = $($error.Count) " -BackgroundColor Red
       }