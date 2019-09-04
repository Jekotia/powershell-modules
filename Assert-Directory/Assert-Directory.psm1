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
    LASTEDIT: July 30, 2019
#>
function Assert-Directory {
    Param
    (
        [Parameter(Mandatory=$true)]
        [String[]]
        $Path
    )

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

    if ((Get-Item "$($Path)") -is [System.IO.FileInfo]) {
        #Write-Debug "$Path is a file."
        return $false
    } elseif ( (Get-Item "$($Path)") -is [System.IO.DirectoryInfo] ) {
        #Write-Debug "$Path is a directory."
        return $true
    } else {
        Throw "An unexpected exception has occurred."
    }
}

New-Alias `
    -Name Confirm-Directory`
    -Value Assert-Directory

Export-ModuleMember `
    -Function Assert-Directory
    -Alias Confirm-Directory