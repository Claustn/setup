function Start-Setup {
    Write-Output "Beginning the set-up"

    Get-ChildItem .\modules\*.psm1 | Import-Module -Force

    $chocopkgs = Get-ChocoPackages "chocopkg.txt"
    Install-ChocoPackages $chocopkgs 1
        
    Invoke-TemporaryZipDownload "colortool" "https://github.com/Microsoft/console/releases/download/1810.02002/ColorTool.zip" {
        & ./colortool "-d" "-b" "-x" "solarized_dark"
    }

    Install-ChocoPackages $chocopkgs 2
    Install-ChocoPackages $chocopkgs 3

    Remove-TempDirectory
}