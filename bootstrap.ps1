# Settings
$repoUri = 'https://github.com/claustn/setup.git'
$setupPath = "./claustn-setup"
$Cred = Get-Credential
Push-Location "/"

# Adjust the execution policy for a programming environment
Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force

# Install chocolately, the minimum requirement
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

iex ((new-object net.webclient).DownloadString('https://boxstarter.org/bootstrapper.ps1'))
Get-Boxstarter -Force

# Clean if necessary
if (Test-Path -Path $setupPath) {
    Remove-Item $setupPath -Recurse -Force
}

# Install git
& choco install git --confirm --limit-output

# Reset the path environment
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

# Clone the setup repository
& git clone $repoUri $setupPath

# Enter inside the repository and invoke the real set-up process
Push-Location $setupPath
Import-Module '.\setup.psm1' -Force

if ($debug -ne $true) {
    Start-Setup
    Install-Boxstarterpackage -PackageName 

    # Clean
    Pop-Location
    Pop-Location
}
