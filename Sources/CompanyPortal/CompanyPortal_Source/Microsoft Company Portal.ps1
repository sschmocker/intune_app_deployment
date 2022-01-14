$Path = "$PSScriptRoot"
Get-Childitem $Path -filter *.appxbundle | %{Add-AppxPackage -Path $_.FullName -ForceApplicationShutdown}
Get-ChildItem $Path -Filter *.msixbundle | %{Add-AppxPackage -Path $_.FullName -ForceApplicationShutdown}
Get-Childitem $Path -filter *.appx| %{Add-AppxPackage -Path $_.FullName -ForceApplicationShutdown}
