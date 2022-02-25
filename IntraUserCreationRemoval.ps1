$csv = Import-Csv "C:\Users\Administrator\Documents\Scripts\IntranetUserCreation\CreatedUsers.csv"



foreach ($user in $csv) {

$error.Clear()

$ID = $user.ID

$getUser = Get-ADUser -Filter "Description -eq $ID" | % { $_.samaccountname }

Remove-ADUser $getUser -Confirm:$false

if ($error) {
    Write-Output "$getUser $ID failed to remove" >> C:\Users\Administrator\Documents\Scripts\Failed2RemoveUsers.txt
    } else {
        Write-Output "$getUser $ID removed" >> C:\Users\Administrator\Documents\Scripts\RemovedUsers.txt
        }
}