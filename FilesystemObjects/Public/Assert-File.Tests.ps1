Describe 'Testing of the Assert-File function' {
    . (Join-Path $PSScriptRoot "Common.Tests.ps1")

    It 'A blank path.' {
        { Assert-File -Path "" } | Should Throw
    }

    It 'A non-existant path: false' {
        #{ Assert-File -Path "$Path" } | Should Throw "$Path does not exist."
        Assert-File -Path "$TestsPath\False\Path\No\Really\You\Would\Have\To\Be\Trying\To\Defeat\This\Test" |
            Should -Be $false
    }

    It 'A known-existant directory: false' {
        #{ Assert-File -Path "$Path" } | Should Throw "$Path is a directory."
        Assert-File -Path $Normal_Directory |
            Should -Be $false
    }

    It 'A known-existant file: true' {
        Assert-File -Path $Normal_File |
            Should -Be $true
    }
}