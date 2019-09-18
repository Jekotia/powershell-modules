Describe 'Testing of the Get-ReparseType function' {
    . (Join-Path $PSScriptRoot "Common.Tests.ps1")

    It "Test 'SymbolicLink' detection" {
        Get-ReparseType -Path $SymbolicLink_Link |
            Should      -Be "SymbolicLink"

        Get-ReparseType -Path $HardLink_Link |
            Should -Not -Be "SymbolicLink"

        Get-ReparseType -Path $Junction_Link |
            Should -Not -Be "SymbolicLink"
    }

    It "Test 'HardLink' detection" {
        Get-ReparseType -Path $HardLink_Link |
            Should      -Be "HardLink"

        Get-ReparseType -Path $SymbolicLink_Link |
            Should -Not -Be "HardLink"

        Get-ReparseType -Path $Junction_Link |
            Should -Not -Be "HardLink"
    }


    It "Test 'Junction' detection" {
        Get-ReparseType -Path $Junction_Link |
            Should      -Be "Junction"

        Get-ReparseType -Path $SymbolicLink_Link |
            Should -Not -Be "Junction"

        Get-ReparseType -Path $HardLink_Link |
            Should -Not -Be "Junction"
    }

    It "Test for error on directory" {
        { Get-ReparseType -Path $Normal_Directory } |
            Should Throw "Cannot get LinkType from $Normal_Directory because it is not a reparse point."
    }

    It "Test for error on file" {
        { Get-ReparseType -Path $Normal_File } |
            Should Throw "Cannot get LinkType from $Normal_File because it is not a reparse point."
    }
}