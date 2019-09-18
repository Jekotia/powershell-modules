function isDirectory {
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
        if ( (Get-Item -Force "$($Path)") -is [System.IO.DirectoryInfo] ) {
            return $true
        } else {
            return $false
        }
    }
}