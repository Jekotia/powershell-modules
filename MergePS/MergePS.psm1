$Public     = (Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public')   -Recurse -Filter *.ps1 -Exclude *.Tests.ps1)
$Private    = (Get-ChildItem -Path (Join-Path $PSScriptRoot 'Private')  -Recurse -Filter *.ps1 -Exclude *.Tests.ps1 )

foreach ($File in $Public) {
    . $File.FullName
    Export-ModuleMember $File.BaseName
}

foreach ($File in $Private) {
    . $File.FullName
}