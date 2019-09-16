$Private    = (Get-ChildItem -Path (Join-Path $PSScriptRoot 'Private')  -Recurse -Filter *.ps1 -Exclude *.Tests.ps1 )
$Public     = (Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public')   -Recurse -Filter *.ps1 -Exclude *.Tests.ps1)

foreach ($Script in $Public) {
    . $Script.FullName
    Export-ModuleMember $Script.BaseName
}

foreach ($Script in $Private) {
    . $Script.FullName
}