Describe 'Testing of the Assert-ReparsePoint function' {
    
    . (Join-Path $PSScriptRoot "Common.Tests.ps1")
    
    It "Test 'SymbolicLink' assertion" {
        Assert-ReparsePoint -Path $SymbolicLink_Link |
            Should -Be $true
    }

    It "Test 'HardLink' assertion" {
        Assert-ReparsePoint -Path $HardLink_Link |
            Should -Be $true
    }

    It "Test 'Junction' assertion" {
        Assert-ReparsePoint -Path $Junction_Link |
            Should -Be $true
    }

    It "Test for false on directory" {
        Assert-ReparsePoint -Path $Normal_Directory |
            Should -Be $false
    }

    It "Test for false on file" {
        Assert-ReparsePoint -Path $Normal_File |
            Should -Be $false
    }
    It "Test for false non-existant" {
        Assert-ReparsePoint -Path "$Tests_Base\Absent" |
            Should -Be $false
    }
}