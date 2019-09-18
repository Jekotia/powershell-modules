<#
.SYNOPSIS
    Asserts that the provided path exists and is a directory.

.DESCRIPTION
    Checks the target path against the following potentials:
        a) does not exist
        b) exists as a file
        c) exists as a directory.
    Returns true if the path exists as a directory, and false otherwise.

.PARAMETER Path
    Required. The path to assert.

.EXAMPLE
    Assert-Directory -Path "C:\Windows\system32"

.NOTES
    LASTEDIT: September 16, 2019
#>
function Assert-Directory {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline,Mandatory=$true)]
        [string]
        $Path
    )
    Begin {
        $LocalErrorAction = ErrorAction -Default 'Stop' -BoundParameters $MyInvocation.BoundParameters
    }
    Process {
        # Trim trailing \, if present, for consistency
        $Path = "$Path".TrimEnd('\')

        if ( [string]::IsNullOrEmpty("$Path") ) {
            #Write-Debug "Path is empty."
            return $false
        }
        if ( -Not (Test-Path "$Path") ) {
            #Write-Debug "$Path does not exist."
            return $false
        }

        if ( isFile $Path ) {
            #Write-Debug "$Path is a file."
            return $false
        } elseif ( isDirectory $Path ) {
            #Write-Debug "$Path is a directory."
            return $true
        } else {
            Throw "An unexpected exception has occurred."
        }
    }
}