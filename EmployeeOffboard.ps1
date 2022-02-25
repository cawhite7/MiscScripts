

$error.clear()
$errorActionPreference = 'SilentlyContinue'

# Password Generator
    # Function Supply ASCII Decimal
        function Get-RandomChar {
        $getRandom = Get-Random -Minimum 33 -Maximum 126

        return [char]$getRandom
        }

    # Function Generate Password
        function Get-RandomConc {
        $passed1 = "$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)"
        $passed2 = "$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)"
        $passed3 = "$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)"
        $passed4 = "$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)"
    
        $passedAll = "$passed1$passed4$passed3$passed2"

        return $passedAll
        }

Import-Module ActiveDirectory

$credentials = Get-Credential -Message "`n  Please provide authorized credentials.`n`n  Include potawatomi.org\`n"

do {

    [console]::WriteLine("`nEnter usernames one at a time. When finished, just press enter.`n")

    $users = @()

    $catch = ''


    do {

        $user = Read-Host "  Type username"

        if ($user -ne ''){
                            $users += $user
        }

    } until ($user -eq '')


    foreach ($adcheck in $users){

        $getUser = Get-ADUser $adcheck -Credential $credentials

        if ($error) {
            [console]::WriteLine("`n$adcheck error, script terminating and restarting`n")
            $catch = 'Error return'

            $error[0] > "$($env:TEMP)\GetUser.txt"

            Start-Process Notepad.exe -PassThru "$($env:TEMP)\GetUser.txt"

            Start-Sleep -Seconds 3
        }

    }

} while ($catch -eq 'Error return')



foreach ($rmUser in $users) {
    
    try {
        $groups = Get-ADPrincipalGroupMembership -Identity $rmUser -Credential $credentials | where {$_.Name -ne "Domain Users"}

        if ($groups -ne $null) {
            Remove-ADPrincipalGroupMembership -Identity $rmUser -MemberOf $groups -Confirm:$false -Credential $credentials
        }

        [console]::WriteLine("`n$rmUser only member of Domain Users")

    } catch {
        
        [console]::WriteLine("Failed to remove user from groups, error dumped to log %TEMP%\FailedRMGroup.txt and script is terminating")
        
        $error[0] > "$($env:TEMP)\FailedRMGroup.txt"

        Start-Process Notepad.exe -PassThru "$($env:TEMP)\FailedRMGroup.txt"

        Start-Sleep -Seconds 3
        exit

    }

    $password = "$(Get-RandomConc)"

    try {
         $error.Clear()
         Set-ADAccountPassword -Identity $rmUser -NewPassword (ConvertTo-SecureString -String $password -AsPlainText -Force) -Credential $credentials

    } catch {
            [console]::WriteLine("Failed to set password, error dumped to log %TEMP%\FailedSetPW.txt and script is terminating")
        
            $error[0] > "$($env:TEMP)\FailedSetPW.txt"

            Start-Process Notepad.exe -PassThru "$($env:TEMP)\FailedSetPW.txt"

            Start-Sleep -Seconds 3
            exit
    }

    try {

    $error.Clear()

    Start-Sleep -Seconds 1

    Disable-ADAccount -Identity $rmUser -Credential $credentials

    } catch {
        
        [console]::WriteLine("Failed to disable account, error dumped to log %TEMP%\FailedUserDisable.txt and script is terminating")

        $error[0] > "$($env:TEMP)\FailedUserDisable.txt"

        Start-Process Notepad.exe -PassThru "$($env:TEMP)\FailedUserDisable.txt"

        Start-Sleep -Seconds 3
        exit
    }

    [console]::WriteLine("`nCompleted")
    Start-Sleep -Seconds 3

}
