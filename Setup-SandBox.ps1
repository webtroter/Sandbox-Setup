Enable-PSRemoting -force -SkipNetworkProfileCheck

Install-PackageProvider -name nuget -force -forcebootstrap -scope allusers
Update-Module PackageManagement, PowerShellGet -force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name BurntToast -Repository PSGallery -Force -Confirm:$false; Import-Module BurntToast
New-BurntToastNotification -Text "BurntToast is installed"

#run updates and installs in the background
$chocojob = Start-Job -FilePath C:\Sandbox\Install-Chocolatey.ps1 -Name "Chocolatey Job"
# Start-Job { Install-Module PSReleaseTools -force; Install-PowerShell -mode quiet -enableremoting -EnableContextMenu }
$wtjob = Start-Job -FilePath C:\Sandbox\Install-WindowsTerminal.ps1
$vscodejob = Start-Job -FilePath C:\Sandbox\Install-VSCodeSandbox.ps1

# Get-Job $chocojob | Wait-Job; $adsjob = Start-Job -FilePath C:\Sandbox\Install-DotNetInteractive.ps1

$chocojobburnt = Register-ObjectEvent -InputObject $chocojob -EventName StateChanged -Action {
    New-BurntToastNotification -Text "Job: $($chocojob.Name) completed"
    $chocojobburnt | Unregister-Event
}
$wtjobburnt = Register-ObjectEvent -InputObject $wtjob -EventName StateChanged -Action {
    New-BurntToastNotification -Text "Job: $($wtjob.Name) completed"
    $wtjobburnt | Unregister-Event
}
$vscodejobburnt = Register-ObjectEvent -InputObject $vscodejob -EventName StateChanged -Action {
    New-BurntToastNotification -Text "Job: $($vscodejob.Name) completed"
    $vscodejobburnt | Unregister-Event
}
<# $adsjobburnt = Register-ObjectEvent -InputObject $adsjob -EventName StateChanged -Action {
    New-BurntToastNotification -Text "Job: $($adsjob.Name) completed"
    $adsjobburnt | Unregister-Event
} #>


# Start-Job -FilePath C:\Sandbox\Install-DotNetInteractive.ps1

$SandboxHeader = New-BTHeader -Id 1 -Title "Sandbox Setup"
New-BurntToastNotification -Text "Setup-SandBox.ps1 all job launched" -Header $SandboxHeader

#wait for everything to finish
Get-Job | Wait-Job
Export-clixml -InputObject @($chocojob, $wtjob, $vscodejob) -Path C:\jobs.xml
New-BurntToastNotification -Text "Setup-SandBox.ps1 finished" -Header $SandboxHeader
