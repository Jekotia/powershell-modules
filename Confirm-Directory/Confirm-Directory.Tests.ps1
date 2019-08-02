Describe 'Testing of the Confirm-Directory module' {
    Remove-Module -Force -Name Confirm-Directory
    Import-Module -Force -Name .\Confirm-Directory.psm1

    New-Item -Path ".\" -Name "Testing" -ItemType "Directory" -Force
    New-Item -Path ".\Testing" -Name "foo" -ItemType "Directory" -Force
    New-Item -Path ".\Testing\foo" -Name "bar.txt" -ItemType "File" -Force

    It 'A blank path.' {
        { Confirm-Directory -Path "" } | Should Throw
    }

    It 'A non-existant path.' {
        $Path = ".\Testing\FalsePath\NoReally\YouWouldHave\ToBeTrying\ToDefeat\ThisTest"
        #{ Confirm-Directory -Path "$Path" } | Should Throw "$Path does not exist."
        Confirm-Directory -Path "$Path" | Should -Be $false
    }

    It 'A known-existant file.' {
        $Path = ".\Testing\foo\bar.txt"
        #{ Confirm-Directory -Path "$Path" } | Should Throw "$Path is a file."
        Confirm-Directory -Path "$Path" | Should -Be $false
    }

    It 'A known-existant directory.' {
        $Path = ".\Testing\foo"
        Confirm-Directory -Path "$Path" | Should -Be $true
    }

    Remove-Item -Path ".\Testing\foo\bar.txt" -Force
    Remove-Item -Path ".\Testing\foo" -Force
    Remove-Item -Path ".\Testing" -Force
}
