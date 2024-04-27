#---- TEMPORARY ---
Disable-UAC
#--- Windows Settings ---
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
Set-TaskbarSmall

Enable-RemoteDesktop
#Set-TaskbarOptions -Size Small -Lock -Dock Bottom -Combine Always -AlwaysShowIconsOn
Update-ExecutionPolicy
Disable-GameBarTips
Disable-BingSearch


#--- Restore Temporary Settings ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula


wsl --set-default-version 2

$computername = "clausnWin"
if ($env:computername -ne $computername) {
	Rename-Computer -NewName $computername -Restart
}