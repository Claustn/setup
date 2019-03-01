$tempDir = "./.tmp"

function Get-TemporaryDownload([string]$uri) {
    $tmpFile = New-TemporaryFile
    Invoke-WebRequest -Uri $uri -OutFile $tmpFile.FullName

    return $tmpFile.FullName
}

function New-TempDirectory {
    if (!(Test-Path -Path $tempDir)) {
        New-Item -ItemType Directory -Force -Path $tempDir
    }
}

function Remove-TempDirectory {
    if (Test-Path -Path $tempDir) {
        Remove-Item $tempDir -Recurse -Force
    }
}

function Invoke-TemporaryZipDownload([string]$name, [string]$uri, [ScriptBlock]$action) {
    $outFile = Join-Path $tempDir ($name + ".zip")
    $outDir = Join-Path $tempDir $name

    New-TempDirectory

    if (Test-Path -Path $outDir) {
        Remove-Item $outDir -Recurse -Force
    }

    Invoke-WebRequest -Uri $uri -OutFile $outFile
    Expand-Archive $outFile -DestinationPath $outDir -Force

    Push-Location $outDir
    $action.Invoke()
    Pop-Location

    Remove-Item -Path $outFile
    Remove-Item -Path $outDir -Recurse -Force
}

function Install-UserProfile {
    Get-ChildItem -Path './home' |
        Select-Object -ExpandProperty Name |
        Copy-Item -Path $_ -Destination '~/'
}
