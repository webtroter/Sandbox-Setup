
$dotnetHeader = New-BTHeader -Id 5 -Title "dotNet Interactive Setup"
New-BurntToastNotification -Text "dotNet Interactive Installation started" -Header $dotnetHeader

choco install azure-data-studio -y
choco install dotnetcore-sdk -y
choco install anaconda3 -y
# Install-ChocolateyPackage -Name "azure-data-studio", "dotnetcore-sdk" -Confirm:$False
# Install-ChocolateyPackage -Name "anaconda3" -PackageParameters "/AddToPath" -Confirm:$False

dotnet tool install --global Microsoft.dotnet-interactive
dotnet interactive jupyter install

New-BurntToastNotification -Text "dotNet Interactive Installation finished" -Header $dotnetHeader