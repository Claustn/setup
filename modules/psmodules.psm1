
function Install-PSModules {
    param ($PATH = './configs/psmodules.txt')
    
    Get-Content $PATH | ForEach-Object {
        Try {
            $Cmd = "Install-Module -Name $_"
            $Bytes = [System.Text.Encoding]::Unicode.GetBytes($Cmd)
            $EncodedText =[Convert]::ToBase64String($Bytes)            
            powershell.exe -NoProfile -ExecutionPolicy ByPass -EncodedCommand $EncodedText
        }
        Catch {
            Write-Host "Could not install $_"
        }
    }

}


function Install-PSModulesv7 {
    param ($PATH = './configs/psmodules.txt')

    Get-Content $PATH | ForEach-Object {
        Try {
            $Cmd = "Install-Module -Name $_"
            $Bytes = [System.Text.Encoding]::Unicode.GetBytes($Cmd)
            $EncodedText =[Convert]::ToBase64String($Bytes)            
            pwsh.exe -NoProfile -ExecutionPolicy ByPass -EncodedCommand $EncodedText
        }
        Catch {
            Write-Host "Could not install $_"
        }
    }


    
}

