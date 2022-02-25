






<#
           3 Separate New-ADUser methods

           All outputs are stored in current user documents/Scripts/IntranetUserCreation
#>




Import-Module ActiveDirectory


# Initial Variable Declaration
    $error.clear()
    $ErrorActionPreference = "SilentlyContinue"







# Paths
    # Locate CSV
        function Get-File ($initialDirectory){
            [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
            $OpenFile = New-Object System.Windows.Forms.OpenFileDialog
            $OpenFile.InitialDirectory = $initialDirectory
            $OpenFile.Filter = "CSV (*.csv) | *.csv"
            $OpenFile.ShowDialog() | Out-Null

            return $OpenFile.FileName
        }
    # Check Path Exist
        $defaultPath = "$($env:USERPROFILE)\Documents\Scripts\IntranetUserCreation"
        $checkPath = Test-Path -Path $defaultPath
        if ($checkPath -eq $True){
            # Empty if
        } else{
            New-Item -ItemType Directory -Force -Path $defaultPath
        }
    # Locations
        $importCSV = Import-Csv -Path (Get-File)
        #$importCSV = Import-Csv "$($env:USERPROFILE)\Documents\Scripts\IntranetUserCreation\NotFoundUsers.csv"
        $passwordsGenerated = "$($env:USERPROFILE)\Documents\Scripts\IntranetUserCreation\IdentsAndPass.txt"
        $createUserErrors = "$($env:USERPROFILE)\Documents\Scripts\IntranetUserCreation\CreateUserErrors.txt"
        $failed2Create = "$($env:USERPROFILE)\Documents\Scripts\IntranetUserCreation\Failed2Create.txt"
        $createdUsers = "$($env:USERPROFILE)\Documents\Scripts\IntranetUserCreation\CreatedUsers.txt"
        $createdUsersCSV = "$($env:USERPROFILE)\Documents\Scripts\IntranetUserCreation\CreatedUsers.csv"
        $existUsers = "$($env:USERPROFILE)\Documents\Scripts\IntranetUserCreation\ExistingUsers.txt"






# Counter
    $c = 0 # foreach loop counter
    $counter = $importCSV.Count







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
    
        $passed = "$passed1$passed2$passed3$passed4"

        return $passed
        }






    # Force CSV format delimits by ,
        Write-Output "" | Export-Csv $createdUsersCSV -NoTypeInformation
        Start-Sleep -Seconds 2 # Delay for csv file to create
        Write-Output "First,Middle,Last,ID,Password,Position,Department,Path" >> $createdUsersCSV # Column Labels






# New User Import
    foreach ($user in $importCSV){




    # Excel Column Properties
        $givenName = $user.First
        $middle = $user.Middle
        $surName = $user.Last
        $ID = $user.ID
        $department = $user.Department
        $position = $user.Position
        $path = $user.Path


    # Property Fillings
            $name = "$givenName $surName"
            $nameInt = "$givenName $initials. $surName"
        $samAccountName = "$($givenName.Substring(0,1))$surName"
        $samAccountNameInt = "$($givenName.Substring(0,1))$initials$surName"
            $UPN = "$samAccountName@potawatomi.org"
            $UPNInt = "$samAccountNameInt@potawatomi.org"
#       $givenName // Declared in Excel Columns
            $displayName = "$givenName $surName"
            $displayNameInt = "$givenName $initials. $surName"
#       $surName = // Declared in Excel Columns
        $description = $ID
        $title = $position
#       $department // Declared in Excel Columns
        $company = "Citizen Potawatomi Nation"
#       $path // Declared in Excel Columns
        $TP = "$(Get-RandomConc)"





        $error.Clear()




        $getUser = Get-ADUser -Filter "Description -eq $ID" # First ifelse statement dependent

    
    
    
    
    
    
    # User Creation
    # Double if // First if statement containts the entire second if statement in the if block

       if ($getUser -eq $null){

            if ($middle -ne "") {

                                    $initials = $middle.Substring(0,1) # Contained in if, else throws errors for blank middles

                                try {

                                        New-ADUser `
                                        -Name $name `
                                        -SamAccountName $samAccountName `
                                        -UserPrincipalName $UPN `
                                        -GivenName $givenName `
                                        -Initials $initials `
                                        -DisplayName $displayName `
                                        -Surname $surName `
                                        -Description $description `
                                        -Title $title `
                                        -Department $department `
                                        -Company $company `
                                        -AccountPassword (ConvertTo-SecureString -String $TP -Force -AsPlainText) `
                                        -Path $path `
                                        -ChangePasswordAtLogon $True `
                                        -Enabled $True

                                        # Outputs
                                        Write-Output "$description = $TP" >> $passwordsGenerated
                                        Write-Output "$givenName,$initials,$surName,$ID,$position,$department" >> $createdUsers
                                        Write-Output "$givenName,$initials,$surName,$ID,$TP,$position,$department,$path" >> $createdUsersCSV

                                    } catch {
                            
                                                $error.Clear()

                                                New-ADUser `
                                                -Name $nameInt `
                                                -SamAccountName $samAccountNameInt `
                                                -UserPrincipalName $UPNInt `
                                                -GivenName $givenName `
                                                -Initials $initials `
                                                -DisplayName $displayNameInt `
                                                -Surname $surName `
                                                -Description $description `
                                                -Title $title `
                                                -Department $department `
                                                -Company $company `
                                                -AccountPassword (ConvertTo-SecureString -String $TP -Force -AsPlainText) `
                                                -Path $path `
                                                -ChangePasswordAtLogon $True `
                                                -Enabled $True

                                                # Outputs
                                                Write-Output "$description = $TP" >> $passwordsGenerated
                                                Write-Output "$givenName,$initials,$surName,$ID,$position,$department" >> $createdUsers
                                                Write-Output "$givenName,$initials,$surName,$ID,$TP,$position,$department,$path" >> $createdUsersCSV
                            
                                            }

                                if ($error) {

                                                Write-Output "$samAccountName $ID error in creation" >> $failed2Create
                                                Write-Output "$($error[0])" >> $failed2Create

                                                Write-Output "$(Get-ADUser $samAccountName -Properties SamAccountName,Description -ErrorAction Ignore | `
                                                              % { $_.SamAccountName,$_.Description }) & $(Get-ADUser $samAccountNameInt -Properties SamAccountName,Description -ErrorAction Ignore | `
                                                              % { $_.SamAccountName,$_.Description }) Exists `n" >> $failed2Create

                                                Write-Output "" >> $failed2Create

                                            }

                                } else {
                    
                                            $error.Clear()

                                            New-ADUser `
                                            -Name $name `
                                            -SamAccountName $samAccountName `
                                            -UserPrincipalName $userPrincipalName `
                                            -GivenName $givenName `
                                            -DisplayName $displayName `
                                            -Surname $surName `
                                            -Description $description `
                                            -Title $title `
                                            -Department $department `
                                            -Company $company `
                                            -AccountPassword (ConvertTo-SecureString -String $TP -Force -AsPlainText) `
                                            -Path $path `
                                            -ChangePasswordAtLogon $true `
                                            -Enabled $true

                                            if ($error) {

                                                            Write-Output "$samAccountName $ID error in creation" >> $failed2Create
                                                            Write-Output "$($error[0])" >> $failed2Create

                                                            Write-Output "$(Get-ADUser $samAccountName -Properties SamAccountName,Description -ErrorAction Ignore | `
                                                                          % { $_.SamAccountName,$_.Description }) & $(Get-ADUser $samAccountNameInt -Properties SamAccountName,Description -ErrorAction Ignore | `
                                                                          % { $_.SamAccountName,$_.Description }) Exists `n" >> $failed2Create

                                                            Write-Output "" >> $failed2Create

                                                        } else {

                                                                    Write-Output "$description = $TP" >> $passwordsGenerated
                                                                    Write-Output "$givenName,$initials,$surName,$ID,$position,$department" >> $createdUsers
                                                                    Write-Output "$givenName,$initials,$surName,$ID,$TP,$position,$department,$path" >> $createdUsersCSV

                                                                }

                                        }

                                } else { 
                                            Write-Output "User $ID already exists  -  Attempted $givenName $middle $surName" >> $existUsers
                                            Write-Output "" >> $existUsers
                                       }

    # End of Series
    
    $c++

    [console]::WriteLine("$c of $counter $description")

                                 } # END OF FOREACH


