Import-Module -Force -Name "$PSScriptRoot\Choco-Download.psm1"
#Describe 'Testing of the Confirm-Directory module' {
    $TestDownloadPath = "$profile\..\Custom\Modules\Choco\Testing"
    
    New-Item -Type Directory -Path "$TestDownloadPath" -Force
    
    Set-Location "$TestDownloadPath"
#    It 'Multi-package download.' {
        Choco-Download -Packages winamp,malwarebytes #| Should -Be $true
        return
#    }
#}


<#--
    Write-Output "Expect: false"
    Get-FileFromURL -URL "test" -Path "D:\Downloads\choco\Opera.62.0.3331.99.nupkg"

    Write-Output "Expect: true"
    Get-FileFromURL -URL "test" -Path "D:\Downloads\choco"

    Write-Output "Expect: false"
    Get-FileFromURL -URL "test" -Path "D:\Downloads\chocoddadasd\"

    exit
    --#>

    
#$DebugPreference = "Continue"
#choco-download "firefox,opera" "D:\Downloads\choco"

<#--
if ($testing = $true) {
    $DebugPreference = "Continue"
    Import-Module ..\Confirm\DirectoryExists.psm1
    Import-Module ..\Get\FileFromURL.psm1 -Force
    #Import-Module .\download.ps1
    ChocoDownload "firefox,opera" "D:\Downloads\choco"
    return
}
#$DebugPreference = "Continue" ; Import-Module .\functions\Confirm\DirectoryExists.psm1,.\functions\Get\FileFromURL.psm1 -Force ; .\functions\choco\download.ps1 ; ChocoDownload "firefox,opera" "D:\Downloads\choco"

$testing = $true
--#>