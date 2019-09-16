function Invoke-MergePS {
    Param (
        # Help text
        [Parameter(Mandatory=$true)]
        [String]
        $Path,
        # Help text
        #[Parameter(Mandatory=$true)]
        [switch]
        $Build=$false,
        # Help text
        #[Parameter(Mandatory=$true)]
        [switch]
        $WhatIf=$false
    )

    #Import-Module Configuration

    #$DebugPreference = 'Continue'

    # Primary variable for storing the output to be written to file
    $Script:Output = @()
    $Script:Version = ''

    #& $Path

    
    $OutputPath = (Resolve-Path $Path).Path
    $OutputPath = Split-Path -Parent $OutputPath
    
    $OutputFileName = (Get-Item $Path).BaseName
    $OutputFileName = $OutputFileName + ".Merged.ps1"
    
    $Script:OutputFile = Join-Path $OutputPath $OutputFileName
    if (Test-Path $Script:OutputFile) {
        Remove-Item -Force $Script:OutputFile -WhatIf:$Whatif
    }

    New-Item -Path $Script:OutputFile -ItemType File
    Set-ItemProperty -Path $Script:OutputFile -Name IsReadOnly -Value $True

    if (ImportFile -File $Path -GetVersion) {
        Write-Output "DONE"
    }

    if ($build){}

}

Export-ModuleMember Invoke-MergePS

<#
function appendFile {
    Param (
        [Parameter(Mandatory=$true,ParameterSetName="File")]
        [string]
        $File,
        [Parameter(Mandatory=$true,ParameterSetName="String")]
        [string]
        $String,
        [Parameter(Mandatory=$false)]
        [array]
        $Remove,
        [Parameter(Mandatory=$false)]
        [array]
        $Replace
    )
    try {
        if ($PSBoundParameters.ContainsKey('File')) {
            #Write-Output "File: $file"
            $Content = Get-Content $File
        } else {
            #Write-Output "String: $String"
            $Content = $String
        }

        foreach ($i in $Remove) {
            $Content = $Content -replace $i,''
        }

        foreach ($i in $Replace) {
            $Content = $Content -replace $i.Find,$i.Replace
        }

        $Content | Add-Content $Script:OutFile
        Write-Output "Successfully appended $File$String"
    } catch {
        Write-Output "Failed to append $file"
    }
    Start-Sleep -Milliseconds 500
}
#>