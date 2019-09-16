function ImportFile {
    Param (
        # Help text
        [Parameter(Mandatory=$true)]
        [String]
        $File,
        # Help text
        [switch]
        $GetVersion
    )

    # Get the content of a file
    $Content = Get-Content $File
    # Split the content per-line into an array of individual lines
    $Content = $Content -split "`r`n"
    
    # Indicate in the output where this file begins
    <#$Script:Output += ("")
    $Script:Output += ("## BEGIN $File")
    $Script:Output += ("")#>
    #WriteLine -Line ""
    #WriteLine -Line "`n## BEGIN $File`n"
    #WriteLine -Line ""

    # https://stackoverflow.com/a/31564924/1871306
    ForEach ($Line in $Content) {
        Write-Debug "Line text: $Line"

        if (
            (
                $GetVersion
            ) -And ( #-Not
                $true #$Script:Version
            )
        ) {
            $LineVersion = $Line -Match '\s*\$Version\s\=\s(.*)'
            if ($LineVersion) {
                $Script:Version = $matches[1]
                Write-Debug $Script:Version
            }
        }

        if ($Line -Match "\<\#") {
            Write-Warning 'LineSkip: true'
            #pause
            $LineSkip = $true
        } elseif ($LineSkip -And ($Line -Match "\#\>") ) {
            Write-Warning 'LineSkip: false'
            #pause
            $LineSkip = $false
        } elseif ($LineSkip) {
            Write-Debug "Skipping: $Line"
        } elseif (-Not (Directives -Line $Line)) {
            # Check if the current line dot-sources a file
            $LineDotSource = $Line -Match '^\s*\.'

            if ($LineDotSource) {
                Write-Debug "Found dot-sourced file: $DotFile"
                # Check if we were able to extract the file path from the line
                if ($DotFile = ExtractDotFilePathFromString -Line $Line ) {
                    
                    $DotFile = ProcessExtractedPath -FilePath $DotFile -Context $File
                    ImportFile -File $DotFile
                } else {
                    Throw
                }
            } else {
                if ($Line -Match "^\s*Import\-Module" ) {
                    Write-Warning "MergePS will not Merge module contents into its output."
                }
                #$Script:Output += ($Line)
                WriteLine -Line $Line
            }
        }
    }

    # Indicate in the output where this file ends
    <#$Script:Output += ("")
    $Script:Output += ("## END $File")
    $Script:Output += ("")#>
    #WriteLine -Line ""
    #WriteLine -Line "`n## END $File`n"
    #WriteLine -Line ""

    return $true
}