function ProcessExtractedPath {
    Param (
        # The path extracted, in need of verification and processing
        [Parameter(Mandatory=$true)]
        [String]
        $FilePath,
        # The path of the file from which $Path was extracted
        [Parameter(Mandatory=$true)]
        [String]
        $Context
    )

    # Turn $Context into a fully resolved path to the directory containing the file
    $Context = (Resolve-Path $Context).Path
    $Context = Split-Path -Parent $Context
    Write-Debug "`$Context = $Context"

    # Use regex to test if the FilePath uses $PSScriptRoot. If it does, we remove it from the FilePath because it would be equivalent to $Context
    $TestPath = $FilePath -match '^\$PSScriptRoot\\(.*)$'
    if ($TestPath) {
        Write-Debug "`$FilePath = $FilePath"
        $FilePath = $matches[1]
    }
    Write-Debug "`$FilePath = $FilePath"

    $Path = Join-Path $Context $FilePath
    Write-Debug "`$Path = $Path"

    # Validate path
    # Ensure that our finalised path is indeed a file
    if ( (Get-Item -Force "$($Path)") -is [System.IO.FileInfo] ) {
        Write-Debug "`$Path is a file."
        return $Path
    } elseif ( (Get-Item -Force "$($Path)") -is [System.IO.DirectoryInfo] ) {
        Write-Error "The resolved path is a Directory. This cannot be imported in this manner."
        return $false
    } else {
        Write-Error "An unknown error has occurred."
        return $false
    }
        
    #$DotFile = $Line -match "^\s*\.\s(?:\`"|\`')(.*)(?:\`"|\`')"
    #if ($DotFile) {
    #    $DotFile = $matches[1]
    #    return $DotFile
    #}
}