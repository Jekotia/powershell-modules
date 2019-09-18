<#
.SYNOPSIS
    Gets the type of reparse point of the target.

.DESCRIPTION
    Checks the target and returns the type of reparse point, or false if it is not.

.PARAMETER Path
    Required. The path to get the value from.

.EXAMPLE
    Get-ReparseType -Path "C:\Windows\system32"

.NOTES
    LASTEDIT: September 16, 2019
#>
function Get-ReparseType {
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
        $ReparseType = Get-ItemPropertyValue -Path $Path -Name LinkType -ErrorAction $LocalErrorAction

        if ($ReparseType) {
            return $ReparseType
        } else {
            if (Test-Path $Path) {
                Throw [System.InvalidOperationException] "Cannot get LinkType from $Path because it is not a reparse point."
            }
        } else {
        }
    }
}
#Import-Module -Force FilesystemObjects ; Get-ReparseType dsada