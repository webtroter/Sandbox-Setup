$wtHeader = New-BTHeader -Id 4 -Title "Windows Terminal Setup"
New-BurntToastNotification -Text "Starting WT Installation" -Header $wtHeader
Install-Module WTToolbox -force
New-BurntToastNotification -Text "Launching Windows Terminal Installation" -Header $wtHeader
Install-WTRelease
New-BurntToastNotification -Text "Windows Terminal installed" -Header $wtHeader