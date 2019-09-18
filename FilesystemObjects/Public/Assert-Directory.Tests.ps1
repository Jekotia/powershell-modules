Describe 'Testing of the Assert-Directory function' {
    . (Join-Path $PSScriptRoot "Common.Tests.ps1")

    It 'A blank path.' {
        { Assert-Directory -Path "" } | Should Throw
    }

    It 'A non-existant path: false' {
        #{ Assert-Directory -Path "$Path" } | Should Throw "$Path does not exist."
        Assert-Directory -Path "$Tests_Base\False\Path\No\Really\You\Would\Have\To\Be\Trying\To\Defeat\This\Test" |
            Should -Be $false
    }

    It 'A known-existant file: false' {
        #{ Assert-Directory -Path "$Path" } | Should Throw "$Path is a file."
        Assert-Directory -Path $Normal_File |
            Should -Be $false
    }

    It 'A known-existant directory: true' {
        Assert-Directory -Path $Normal_Directory |
            Should -Be $true
    }
}