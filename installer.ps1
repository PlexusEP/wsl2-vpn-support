 # Self Elevate Script to Administrator Mode
If (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Write-Host " Launching in Admin mode" -f DarkRed
    $pwshexe = (Get-Command 'powershell.exe').Source
    Start-Process $pwshexe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}
 
 $username = read-host "Enter your username like you would for logging into the VPN(ie na\nick.crowley)"

 if (Get-ScheduledTask WSL2Update -ErrorAction Ignore) {
    Unregister-ScheduledTask -TaskName "WSL2Update" -TaskPath "\TASK-PATH-TASKSCHEDULER\" -Confirm:$false
 }
 
 Register-ScheduledTask -xml (Get-Content $HOME\scripts\UpdateWSL2RoutingforVPN.xml | out-string) -TaskName "WSL2Update" -TaskPath "\TASK-PATH-TASKSCHEDULER\" -user $username