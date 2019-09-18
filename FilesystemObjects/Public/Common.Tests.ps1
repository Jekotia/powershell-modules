if (Get-Module FilesystemObjects) {
    Remove-Module -Force -Name FilesystemObjects
}
Import-Module -Force -Name "$PSScriptRoot\.."

$Tests_Base = Join-Path $PSScriptRoot "Tests"

<#
@{
    ItemType  = "File"
    LinkType  = "SymbolicLink"
    Dir       = ""
    Link      = "bar"
    Target    = "foo"
}
$Test.Dir       = Join-Path $TestBase   $Test.LinkType
$Test.Link      = Join-Path $Test.Dir   $Test.Link
$Test.Target    = Join-Path $Test.Dir   $Test.Target
#>

#$Base = Join-Path $Tests_Base "GetReparseTarget"
## SymbolicLink
$SymbolicLink_Dir    = Join-Path $Tests_Base        "SymbolicLink"
$SymbolicLink_Link   = Join-Path $SymbolicLink_Dir  "bar"
$SymbolicLink_Target = Join-Path $SymbolicLink_Dir  "foo"

## HardLink
$HardLink_Dir        = Join-Path $Tests_Base        "HardLink"
$HardLink_Link       = Join-Path $HardLink_Dir      "bar"
$HardLink_Target     = Join-Path $HardLink_Dir      "foo"

## Junction
$Junction_Dir        = Join-Path $Tests_Base        "Junction"
$Junction_Link       = Join-Path $Junction_Dir      "bar"
$Junction_Target     = Join-Path $Junction_Dir      "foo"

## False
$Normal_Directory    = Join-Path $Tests_Base        "Normal_Directory"
$Normal_File         = Join-Path $Tests_Base        "Normal_File"