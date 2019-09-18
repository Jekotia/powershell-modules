Describe 'Testing of the Get-ReparseTarget function' {
    . (Join-Path $PSScriptRoot "Common.Tests.ps1")
    
    $TestBase = "$PSScriptRoot\test"
    write-output "Tests directory: $TestBase"
    
    It "Test 'SymbolicLink' target acquisition" {
        Get-ReparseTarget -Path $SymbolicLink_Link |
            Should -Be $SymbolicLink_Target
    }

    It "Test 'HardLink' target acquisition" {
        Get-ReparseTarget -Path $HardLink_Link |
            Should -Be $HardLink_Target
    }

    It "Test 'Junction' target acquisition" {
        Get-ReparseTarget -Path $Junction_Link |
            Should -Be $Junction_Target
    }

    It "Test for error on directory" {
        { Get-ReparseTarget -Path $Normal_Directory } |
            Should Throw "Cannot get Target from $Normal_Directory because it is not a reparse point."
    }

    It "Test for false on file" {
        { Get-ReparseTarget -Path $Normal_File } |
            Should Throw "Cannot get Target from $Normal_File because it is not a reparse point."
    }
}