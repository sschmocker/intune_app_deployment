New-Item -Path HKCU:\Network\x
New-ItemProperty -Path HKCU:\Network\x -Name "ConnectionType" -Value "1" -PropertyType DWORD -Force 
New-ItemProperty -Path HKCU:\Network\x -Name "DeferFlags" -Value "4" -PropertyType DWORD -Force 
New-ItemProperty -Path HKCU:\Network\x -Name "ProviderName" -Value "Microsoft Windows Network" -PropertyType String -Force 
New-ItemProperty -Path HKCU:\Network\x -Name "ProviderType" -Value "20000" -PropertyType DWORD -Force 
New-ItemProperty -Path HKCU:\Network\x -Name "RemotePath" -Value "\\test\123" -PropertyType String -Force 
New-ItemProperty -Path HKCU:\Network\x -Name "UserName" -Value "0" -PropertyType DWORD -Force 
New-ItemProperty -Path HKCU:\Network\x -Name "UseOptions" -PropertyType Binary -Force 