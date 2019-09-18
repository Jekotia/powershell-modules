function isFile {
    Param
    (
        [Parameter(Mandatory=$true)]
        [String[]]
        $Path
    )

    if ( (Get-Item -Force "$($Path)") -is [System.IO.FileInfo] ) {
        return $true
    } else {
        return $false
    }
}