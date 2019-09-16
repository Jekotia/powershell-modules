function WriteLine {
    Param (
        # Help text
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String]
        $Line
    )

    <#$OutputPath = (Resolve-Path $Source).Path
    $OutputPath = Split-Path -Parent $OutputPath

    $OutputFileName = (Get-Item $Source).BaseName
    $OutputFileName = $OutputFileName + ".Merged.ps1"

    $OutputFile = Join-Path $OutputPath $OutputFileName#>

    # = (Resolve-Path $SourcePath).Path
    #$OutputFile = Split-Path -Parent $OutputFile
    #return $OutputFile

#    if (Test-Path $OutputFile) {
#        Remove-Item -Force $OutputFile -WhatIf:$Whatif
#    }

#Write-Warning "OutputFile $Script:OutputFile"
#Write-Warning "Line $Line"
    Add-Content -Force $Script:OutputFile -WhatIf:$Whatif $Line
    #try {Add-Content -Force $OutputFile -WhatIf:$Whatif $Line} catch {WriteLine -Line $Line}
    <#$OutputContents =# > $Script:Output -join "`r`n" | #Out-String
    #While ($true) {
        if (Add-Content $OutputFile -WhatIf:$Whatif $Line) {
            break
        }
        #}
    #>
}