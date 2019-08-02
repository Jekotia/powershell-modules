Describe 'Testing of the Confirm-File module' {
    Import-Module -Force -Name .\Confirm-File.psm1

    New-Item -Path ".\" -Name "Testing" -ItemType "Directory" -Force
    New-Item -Path ".\Testing" -Name "foo" -ItemType "Directory" -Force
    New-Item -Path ".\Testing\foo" -Name "bar.txt" -ItemType "File" -Force

    It 'A blank path.' {
        { Confirm-File -Path "" } | Should Throw
    }

    It 'A non-existant path.' {
        $Path = ".\Testing\FalsePath\NoReally\YouWouldHave\ToBeTrying\ToDefeat\ThisTest"
        #{ Confirm-File -Path "$Path" } | Should Throw "$Path does not exist."
        Confirm-File -Path "$Path" | Should -Be $false
    }

    It 'A known-existant directory.' {
        $Path = ".\Testing\foo"
        #{ Confirm-File -Path "$Path" } | Should Throw "$Path is a directory."
        Confirm-File -Path "$Path" | Should -Be $false
    }

    It 'A known-existant file.' {
        $Path = ".\Testing\foo\bar.txt"
        Confirm-File -Path "$Path" | Should -Be $true
    }

    Remove-Item -Path ".\Testing\foo\bar.txt" -Force
    Remove-Item -Path ".\Testing\foo" -Force
    Remove-Item -Path ".\Testing" -Force
}
