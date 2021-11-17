
$chocoHeader = New-BTHeader -Id 2 -Title "Chocolatey Setup"
New-BurntToastNotification -Text "Starting Chocolatey installation" -Header $chocoHeader

Install-Module Chocolatey, BetterCredentials -Repository PSGallery -Force -Confirm:$false
New-BurntToastNotification -Text "Chocolatey module installed, launching chocolatey install" -Header $chocoHeader
Install-ChocolateySoftware
New-BurntToastNotification -Text "Chocolatey installed" -Header $chocoHeader

Start-Job -FilePath C:\Sandbox\Install-DotNetInteractive.ps1