Get-ChildItem .\modules\common.psm1 | Import-Module -Force

function Install-VsCodeExtensionFromUrl([string]$name, [string]$url) {
    Get-DownloadTemporaryFile $name $url {
        & code "--install-extension" $name
    }
}

function Install-VsCodeExtension([string]$name) {
    & code "--install-extension" $name
}

function Install-VsCodeExtensions([string]$configFileName) {
        Get-Content $configFileName |
        Where-Object { $_[0] -ne '#' -and $_.Length -gt 0 } |
        ForEach-Object {
            Install-VsCodeExtension $_
        }
    }
