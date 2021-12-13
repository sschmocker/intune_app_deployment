$Path = "$PSScriptRoot"
Get-ChildItem $Path -Filter *msixbundle | %{Add-AppxPackage -Path $_.FullName}
Get-Childitem $Path -filter *.appx| %{Add-AppxPackage -Path $_.FullName}
Get-Childitem $Path -filter *.appxbundle | %{Add-AppxPackage -Path $_.FullName}