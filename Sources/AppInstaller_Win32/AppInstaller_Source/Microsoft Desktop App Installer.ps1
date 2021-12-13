$Path = "$PSScriptRoot"
Get-Childitem $Path -filter *.appx| %{Add-AppxPackage -Path $_.FullName}
Get-ChildItem $Path -Filter *msixbundle | %{Add-AppxPackage -Path $_.FullName}
