# This file is used to create all of the Items used to test functions within this module.
# Creation is handled outside of the pester tests due to elevated rights requirements when creating reparse points.
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    $ScriptPath = $MyInvocation.MyCommand.Definition
    # Relaunch as an elevated process:
    Start-Process powershell.exe "-File",('"{0}"' -f $ScriptPath) -Verb RunAs -Wait
    exit
}
. (Join-Path $PSScriptRoot "Common.Tests.ps1")

# Global Prep
if (Test-Path $Tests_Base) {
    Remove-Item -Recurse -Path "$Tests_Base" -Force | Out-Null
}
New-Item -ItemType Directory -Path "$Tests_Base" | Out-Null

## SymbolicLink
New-Item    -ItemType Directory `
            -Path $SymbolicLink_Dir |
                Out-Null

New-Item    -ItemType File `
            -Path $SymbolicLink_Target |
                Out-Null

New-Item    -ItemType "SymbolicLink" `
            -Path $SymbolicLink_Link  `
            -Value $SymbolicLink_Target |
                Out-Null

## HardLink
New-Item    -ItemType Directory `
            -Path $HardLink_Dir |
                Out-Null

New-Item    -ItemType File `
            -Path $HardLink_Target |
                Out-Null

New-Item    -ItemType "HardLink" `
            -Path $HardLink_Link `
            -Value $HardLink_Target |
                Out-Null

## Junction
New-Item    -ItemType Directory `
    -Path $Junction_Dir |
        Out-Null

New-Item    -ItemType Directory `
    -Path $Junction_Target |
        Out-Null

New-Item    -ItemType "Junction" `
    -Path $Junction_Link `
    -Value $Junction_Target |
        Out-Null

New-Item    -ItemType Directory `
    -Path $Normal_Directory |
        Out-Null

New-Item    -ItemType File `
    -Path $Normal_File |
        Out-Null

pause