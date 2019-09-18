<#
.SYNOPSIS
    Asserts that the provided path exists and is a reparse point.

.DESCRIPTION
    Checks the target path against the following potentials:
        a) exists as a reparse point
    Returns true if the path exists as a reparse point, and false otherwise.

.PARAMETER Path
    Required. The path to assert.

.EXAMPLE
    Assert-ReparsePoint -Path "C:\Windows\system32"

.NOTES
    LASTEDIT: September 16, 2019
#>
function Assert-Reparsepoint {
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
        if (Test-Path $Path) {
            #$ReparsePoint = Get-ItemPropertyValue -Path $Path -Name LinkType -ErrorAction $LocalErrorAction
            try {
                $ReparsePoint = Get-ReparseType -Path $Path -ErrorAction $LocalErrorAction
            } catch [System.InvalidOperationException] {
                return $false
            }

            if ($ReparsePoint) {
                return $true
            } else {
                return $false
            }
        } else {
            return $false
        }
    }
}
# Import-Module -Force FilesystemObjects ; Assert-ReparsePoint dsada -ErrorAction Continue