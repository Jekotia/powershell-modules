function Directives () {
    Param (
        # Help text
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String]
        $Line
    )

    $LineMergePS      = $Line -Match '^\s*#{2}MergePS\s(.*):\s(.*)'
    # Check if the Line has a MergePS directive, and split the directive and value into variables
    if ($LineMergePS) {
        Write-Debug "Line"
        $Directive = $matches[1]
        $Value = $matches[2]

        Write-Debug "`$Directive = $Directive"
        Write-Debug "`$Value = $Value"


        if ($Directive -eq 'RAW') {
            #$Script:Output += ($Line)
            #WriteLine -Line 'RAW'
            WriteLine -Line $Value
            #$MergePS = $LineMergePS -Match '^(\w*)\:\s(.*)'
            return $true

        } elseif ($Directive -eq 'IMPORT') {
            if (Get-Item $Value) {
                ImportFile -File $Value
                return $true
            } else {
                Write-Error "Cannot find file $Value"
                #return $false
            }

        } elseif ($Directive -eq 'IMPORT RAW') {
            Get-Content -Path $Value | Add-Content -Force -Path $Script:OutputFile
            return $true
        } else {
            Write-Error "Invalid directive: $Directive"
            Throw
        }
    }

    $LineEndMergePS   = $Line -Match     '.+#{2}MergePS\s(.*)(?:\:(.*))?$'
    # Check if the LineEnd has a MergePS directive
    if ($LineEndMergePS) {
        Write-Debug "LineEnd"
        $Directive = $matches[1]
        $Value = $matches[2]
        
        Write-Debug "`$Directive = $Directive"
        Write-Debug "`$Value = $Value"


        #$LineEndMergePS -Match '^RAW\:\s(.*)') {

        if ($Directive -eq 'REMOVE') {
            return $true
        } else {
            Write-Error "Invalid directive: $Directive"
            Throw
        }
    }
}