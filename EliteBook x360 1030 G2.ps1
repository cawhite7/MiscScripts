[console]::WindowWidth=50
[console]::WindowHeight=10
[console]::BufferWidth=[console]::WindowWidth

$path = "\\cpnnetworking\networking\Casey White Public\Driver & Firmware Updates\EliteBook x360 1030 G2\Applications"

[console]::WriteLine(     ""     )
[console]::WriteLine("     DO NOT OVERWRITE SAME VERSIONS     "     )
[console]::WriteLine(     ""     )
[console]::WriteLine("     CANCEL IF CURRENT VERSION IS NEWER     "     )
[console]::WriteLine(     ""     )

Write-Host "`r[                  (00.00%)                  ]" -NoNewline

Start-Sleep -Seconds 5

Start-Process "$path\ASMedia eXtensible Host Controller Driver\setup.exe" -Wait
Write-Host "`r[####              (09.09%)                  ]" -NoNewline
Start-Process "$path\Intel Chipset Installation Utility\SetupChipset.exe" -Wait
Write-Host "`r[########          (18.18%)                  ]" -NoNewline
Start-Process "$path\Intel Corporate Management Engine (ME) Firmware\Callinst.exe" -Wait
Write-Host "`r[############      (27.27%)                  ]" -NoNewline
Start-Process "$path\Intel Dynamic Platform and Thermal Framework Driver\setup.exe" -Wait
Write-Host "`r[################  (36.36%)                  ]" -NoNewline
Start-Process "$path\Intel HID Event Filter Driver\Setup.exe" -Wait
Write-Host "`r[##################(45.45%)                  ]" -NoNewline
Start-Process "$path\Intel Sensor Hub Components Driver\SetupISS.exe" -Wait
Write-Host "`r[##################(54.54%)                  ]" -NoNewline
Start-Process "$path\Intel Serial IO Driver\SetupSerialIO.exe" -Wait
Write-Host "`r[##################(63.64%)##                ]" -NoNewline
Start-Process "$path\Intel Thunderbolt 3 Secure Connect\setup.msi" -Wait
Write-Host "`r[##################(72.73%)######            ]" -NoNewline
Start-Process "$path\Intel Thunderbolt 3 Firmware\ThunderboltUpdater.exe" -Wait
Write-Host "`r[##################(81.82%)##########        ]" -NoNewline
Start-Process "$path\Intel Video Driver and Control Panel\igxpin.exe" -Wait
Write-Host "`r[##################(90.91%)##############    ]" -NoNewline
Start-Process "$path\BIOS\HPBIOSUPDREC64.exe" -Wait
Write-Host "`r[##################(100.0%)##################]"

Start-Sleep -Seconds 5