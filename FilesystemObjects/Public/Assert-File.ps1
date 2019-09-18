<#
.SYNOPSIS
    Asserts that the provided path exists and is a file.

.DESCRIPTION
    Checks the target path against the following potentials:
        a) does not exist
        b) exists as a directory
        c) exists as a file.
    Returns true if the path exists as a file, and false otherwise.

.PARAMETER Path
    Required. The path to assert.

.EXAMPLE
    Assert-File -Path "C:\Windows\system32\cmd.exe"

.NOTES
    LASTEDIT: September 16, 2019
#>
function Assert-File {
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
            Write-Debug "Path is empty."
            return $false
        }
        if ( -Not (Test-Path "$Path") ) {
            Write-Debug "$Path does not exist."
            return $false
        }

        if ( isDirectory $Path -ErrorAction $LocalErrorAction ) {
            Write-Debug "$Path is a directory."
            return $false
        } elseif ( isFile $Path ) {
            Write-Debug "$Path is a file."
            return $true
        } else {
            Throw "An unexpected exception has occurred."
        }
    }
}