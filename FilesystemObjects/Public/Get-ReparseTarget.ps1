<#
.SYNOPSIS
    Gets the Target value of a reparse point.

.DESCRIPTION
    Gets the Target value of a provided path, returning the value of the reparse point located there.

.PARAMETER Path
    Required. The path to retrieve the value from.

.EXAMPLE
    Assert-ReparsePoint -Path "C:\Windows\system32"

.NOTES
    LASTEDIT: September 17, 2019
#>
function Get-ReparseTarget {
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
        $ReparseTarget = Get-ItemPropertyValue -Path $Path -Name "Target" -ErrorAction $LocalErrorAction

        if ($ReparseTarget) {
            return $ReparseTarget
        } else {
            if ($LocalErrorAction = 'Stop' ) {
                If (Test-Path $Path) {
                    Throw "Cannot get Target from $Path because it is not a reparse point."
                }
            } else {
                return $false
            }
        }
    }
}
# Import-Module -Force FilesystemObjects ; Get-ReparseTarget dsada -ErrorAction Continue