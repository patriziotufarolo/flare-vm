###########################################
#
# FLARE VM Installation Script
#
# To execute this script:
# 1) Open powershell window as administrator
# 2) Allow script execution by running command "Set-ExecutionPolicy Unrestricted"
# 3) Execute the script by running ".\install.ps1"
#
###########################################

Write-Host "  ______ _               _____  ______   __      ____  __ "
Write-Host " |  ____| |        /\   |  __ \|  ____|  \ \    / /  \/  |"
Write-Host " | |__  | |       /  \  | |__) | |__ _____\ \  / /| \  / |"
Write-Host " |  __| | |      / /\ \ |  _  /|  __|______\ \/ / | |\/| |"
Write-Host " | |    | |____ / ____ \| | \ \| |____      \  /  | |  | |"
Write-Host " |_|    |______/_/    \_\_|  \_\______|      \/   |_|  |_|"
Write-Host "                   I N S T A L L A T I O N                "
Write-Host "  ________________________________________________________"
Write-Host "                         Developed by                     "
Write-Host "                      Peter Kacherginsky                  "
Write-Host "       FLARE (FireEye Labs Advanced Reverse Engineering)  "
Write-Host "  _______________________________________________________ "
Write-Host "                                                          "

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )

if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Host "[ * ] Installing Boxstarter"
  iex ((New-Object System.Net.WebClient).DownloadString('http://boxstarter.org/bootstrapper.ps1')); get-boxstarter -Force

  $passwd=ConvertTo-SecureString -String "vagrant" -AsPlainText -Force
  $cred=New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $env:username, $passwd

  Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/fireeye/flare-vm/master/flarevm_malware.ps1 -Credential $cred

} else {
  Write-Host "[ERR] Please run this script as administrator"
  Read-Host  "      Press ANY key to continue..."
}
