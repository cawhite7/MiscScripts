
#Set Console

[console]::WindowWidth=50
[console]::WindowHeight=20
[console]::BufferWidth=[console]::WindowWidth

Write-Host "Initializing DOC Link installation.....`n`nClosing this window will interrupt the process"

$error.clear
$errorActionPreference = 'SilentlyContinue'

do {

$IoU = Read-Host 'Install or Uninstall? (i/u)'

if ($IoU -eq 'i') {

            Write-Host ''
            
    do {
            
            $admin = Read-Host 'Admin Install? (y/n)'

            if ($admin -eq 'y') {

            Write-Host "`nRunning Microsoft .NET 3.5 Framework...`n"
            DISM /Online /Enable-Feature /FeatureName:NetFx3 /Quiet /All

            $05 = Write-Host "Starting DOC-Link with Admin Installation....."
            $075 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\Admin.txt"
            $085 = Write-Host "`nProgess...`n[                (00.0%)               ]" -NoNewline
            $SmartClient = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\1.exe" -ArgumentList "/passive","/v/qn" -Wait
            $15 = Write-Host "`r[######          (16.7%)               ]" -NoNewline
            $2 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\2\doc-link 3.0 Administrative Components.msi" /passive -wait
            $25 = Write-Host "`r[############    (33.3%)               ]" -NoNewline
            $3 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\3.exe" -ArgumentList "/passive","/v/qn" -Wait
            $35 = Write-Host "`r[################(50.0%)               ]" -NoNewline
            $4 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\4.msi" /passive -wait
            $45 = Write-Host "`r[################(66.7%)###            ]" -NoNewline
            $5 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\5.msi" /passive -wait
            $55 = Write-Host "`r[################(83.3%)#########      ]" -NoNewline
            $6 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\6\Microsoft Dynamics NAV RoleTailored Client2.msi" -wait
            $65 = Write-Host "`r[###############(100.0%)###############]"
            $67 = Write-Host "DOC-Link FINISHED ..... Closing"
            $7 = $05,$075,$085,$SmartClient,$15,$2,$25,$3,$35,$4,$45,$5,$55,$6,$65,$67

            foreach ($appload in $7) {
                                     }

                    $defaultPath = "$($env:PUBLIC)\Desktop\Smart Client.lnk"
                    $checkPath = Test-Path -Path $defaultPath
                    if ($checkPath -eq $true) {
                        # Empty if
                    } else {
                        $WshShell = New-Object -comObject WScript.Shell
                        $Shortcut = $WshShell.CreateShortcut("$($env:PUBLIC)\Desktop\Smart Client.lnk")
                        $Shortcut.TargetPath = "C:\Program Files (x86)\Altec\AppLauncher\Altec.AppLauncher.exe"
                        $Shortcut.Save()
                            }


                    $defaultPath2 = "$($env:PUBLIC)\Desktop\Microsoft Dynamics NAV.lnk"
                    $checkPath2 = Test-Path -Path $defaultPath2
                    if ($checkPath2 -eq $true){
                        # Empty if
                    } else {
                        $WshShell = New-Object -comObject WScript.Shell
                        $Shortcut = $WshShell.CreateShortcut("$($env:PUBLIC)\Desktop\Microsoft Dynamics NAV.lnk")
                        $Shortcut.TargetPath = "C:\Program Files (x86)\Microsoft Dynamics NAV\71\RoleTailored Client\Microsoft.Dynamics.Nav.Client.exe"
                        $Shortcut.Save()
                            }

            Start-Sleep -seconds 3
            break
        }

            elseif ($admin -eq 'n'){

            Write-Host "`nRunning Microsoft .NET 3.5 Framework...`n"
            DISM /Online /Enable-Feature /FeatureName:NetFx3 /Quiet /All

            $205 = Write-Host "Starting DOC-Link Installation....."
            $2075 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\NotAdmin.txt"
            $2085 = Write-Host "`nProgess...`n[                (00.0%)               ]" -NoNewline
            $21 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\1.exe" -ArgumentList "/passive","/v/qn" -Wait
            $215 = Write-Host "`r[########        (20.0%)               ]" -NoNewline
            $23 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\3.exe" -ArgumentList "/passive","/v/qn" -Wait
            $235 = Write-Host "`r[############### (40.0%)               ]" -NoNewline
            $24 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\4.msi" /passive -wait
            $245 = Write-Host "`r[################(60.0%)               ]" -NoNewline
            $25 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\5.msi" /passive -wait
            $255 = Write-Host "`r[################(80.0%)#######        ]" -NoNewline
            $26 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\6\Microsoft Dynamics NAV RoleTailored Client2.msi" -wait
            $265 = Write-Host "`r[###############(100.0%)###############]"
            $267 = Write-Host "DOC-Link FINISHED ..... Closing"
            $27 = $205,$2075,$2085,$21,$215,$22,$225,$23,$235,$24,$245,$25,$255,$26,$265,$267

            foreach ($app in $27){
                                 }

            $defaultPath = "$($env:PUBLIC)\Desktop\Smart Client.lnk"
            $checkPath = Test-Path -Path $defaultPath
            if ($checkPath -eq $true){
                # Empty if
            } else {
                $WshShell = New-Object -comObject WScript.Shell
                $Shortcut = $WshShell.CreateShortcut("$($env:PUBLIC)\Desktop\Smart Client.lnk")
                $Shortcut.TargetPath = "C:\Program Files (x86)\Altec\AppLauncher\Altec.AppLauncher.exe"
                $Shortcut.Save()
                    }


            $defaultPath2 = "$($env:PUBLIC)\Desktop\Microsoft Dynamics NAV.lnk"
            $checkPath2 = Test-Path -Path $defaultPath2
            if ($checkPath2 -eq $true){
                # Empty if
            } else {
                $WshShell = New-Object -comObject WScript.Shell
                $Shortcut = $WshShell.CreateShortcut("$($env:PUBLIC)\Desktop\Microsoft Dynamics NAV.lnk")
                $Shortcut.TargetPath = "C:\Program Files (x86)\Microsoft Dynamics NAV\71\RoleTailored Client\Microsoft.Dynamics.Nav.Client.exe"
                $Shortcut.Save()
                    }

            Start-Sleep -seconds 2
            break
        }

    else {
    Write-Host "Invalid Input"
    $admin = ""
         }
    } while ($true)
    break
}

elseif ($IoU -eq 'u') {

            Write-Host ''

    do {
            $admin = Read-Host 'Admin Uninstall? (y/n)'

            if ($admin -eq 'y') {
            $05 = Write-Host "Starting DOC-Link with Admin Uninstallation....."
            $085 = Write-Host "`nProgess...`n[                (00.0%)               ]" -NoNewline
            $SmartClient = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\1.exe" -Wait
            $15 = Write-Host "`r[######          (16.7%)               ]" -NoNewline
            $2 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\2\doc-link 3.0 Administrative Components.msi" -Wait
            $25 = Write-Host "`r[############    (33.3%)               ]" -NoNewline
            $3 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\3.exe" -Wait
            $35 = Write-Host "`r[################(50.0%)               ]" -NoNewline
            $4 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\4.msi" -Wait
            $45 = Write-Host "`r[################(66.7%)###            ]" -NoNewline
            $5 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\5.msi" -Wait
            $55 = Write-Host "`r[################(83.3%)#########      ]" -NoNewline
            $6 = msiexec.exe /x "\\share\UserAccessApps\StoredApps\DOC-Link\6\Microsoft Dynamics NAV RoleTailored Client2.msi"
            $65 = Write-Host "`r[###############(100.0%)###############]"
            $67 = Write-Host "DOC-Link FINISHED ..... Closing"
            $7 = $05,$075,$085,$SmartClient,$15,$2,$25,$3,$35,$4,$45,$5,$55,$6,$65,$67

            foreach ($appload in $7){
                                    }

                    $defaultPath2 = "$($env:PUBLIC)\Desktop\Microsoft Dynamics NAV.lnk"
                    $checkPath2 = Test-Path -Path $defaultPath2
                    if ($checkPath2 -eq $false) {
                        # Empty if
                    } else {
                        $NAVRemove = "$($env:PUBLIC)\Desktop\Microsoft Dynamics NAV.lnk"
                        Remove-Item $NAVRemove
                            }


            Start-Sleep -seconds 3
            break

        }

            elseif ($admin -eq 'n') {
            $205 = Write-Host "Starting DOC-Link Uninstallation....."
            $2085 = Write-Host "`nProgess...`n[                (00.0%)               ]" -NoNewline
            $21 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\1.exe" -Wait
            $215 = Write-Host "`r[########        (20.0%)               ]" -NoNewline
            $23 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\3.exe" -Wait
            $235 = Write-Host "`r[############### (40.0%)               ]" -NoNewline
            $24 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\4.msi" -Wait
            $245 = Write-Host "`r[################(60.0%)               ]" -NoNewline
            $25 = Start-Process "\\share\UserAccessApps\StoredApps\DOC-Link\5.msi" -Wait
            $255 = Write-Host "`r[################(80.0%)#######        ]" -NoNewline
            $26 = msiexec.exe /x "\\share\UserAccessApps\StoredApps\DOC-Link\6\Microsoft Dynamics NAV RoleTailored Client2.msi"
            $265 = Write-Host "`r[###############(100.0%)###############]"
            $267 = Write-Host "DOC-Link FINISHED ..... Closing"
            $27 = $205,$2085,$21,$215,$22,$225,$23,$235,$24,$245,$25,$255,$26,$265,$267

            foreach ($app in $27){
                                 }

                    $defaultPath2 = "$($env:PUBLIC)\Desktop\Microsoft Dynamics NAV.lnk"
                    $checkPath2 = Test-Path -Path $defaultPath2
                    if ($checkPath2 -eq $false){
                        # Empty if
                    } else {
                        $NAVRemove = "$($env:PUBLIC)\Desktop\Microsoft Dynamics NAV.lnk"
                        Remove-Item $NAVRemove
                            }

            Start-Sleep -seconds 2
            break
        }

    else {
    Write-Host "Invalid Input"
    $admin = ""
         }
    } while ($true)
    break
}

else {
    Write-Host "Invalid Input"
    $IoU = ""
         }
}

while ($true)
