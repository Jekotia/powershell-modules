Import-Module -Name .\Choco-Push.psm1 -Force 3>$null

$DebugPreference = "Continue"

Describe 'Testing of the Choco-Push module' {
    BeforeEach {
        New-Item -Path ".\" -Name "Testing" -ItemType "Directory" -Force
        New-Item -Path ".\Testing" -Name "foo.nupkg" -ItemType "File" -Force
        New-Item -Path ".\Testing" -Name "bar.nupkg" -ItemType "File" -Force
        New-Item -Path ".\Testing" -Name "Nested" -ItemType "Directory" -Force
        New-Item -Path ".\Testing\Nested" -Name "foo.nupkg" -ItemType "File" -Force
        New-Item -Path ".\Testing\Nested" -Name "bar.nupkg" -ItemType "File" -Force
    }

    AfterEach {
        Remove-Item -Path ".\Testing\Nested\foo.nupkg" -Force
        Remove-Item -Path ".\Testing\Nested\bar.nupkg" -Force
        Remove-Item -Path ".\Testing\Nested" -Force
        Remove-Item -Path ".\Testing\foo.nupkg" -Force
        Remove-Item -Path ".\Testing\bar.nupkg" -Force
        Remove-Item -Path ".\Testing" -Force
    }
<#
    `
    "Package: .\Testing\foo.nupkg",`
    "Chocolatey v0.10.15",`
    "An ApiKey was not found for 'https://push.chocolatey.org/'. You must either set an api key in the configuration or specify one with --api-key."
#>
    $ShouldArray =  "Package: .\Testing\foo.nupkg",`
                    "Package: .\Testing\bar.nupkg",`
                    "Package: .\Testing\Nested\foo.nupkg",`
                    "Package: .\Testing\Nested\bar.nupkg",`
                    "Chocolatey v0.10.15",`
                    "An ApiKey was not found for 'https://push.chocolatey.org/'. You must either set an api key in the configuration or specify one with --api-key."

    It 'Single-package push.' {
        Choco-Push -Packages ".\Testing\foo.nupkg" | Should -Be `
            $ShouldArray[0], $ShouldArray[-2], $ShouldArray[-1]
    }

    It 'Multi-package push.' {
        Choco-Push -Packages ".\Testing\foo.nupkg",".\Testing\bar.nupkg" | Should -Be `
            $ShouldArray[0], $ShouldArray[-2], $ShouldArray[-1],`
            $ShouldArray[1], $ShouldArray[-2], $ShouldArray[-1]
    }

    It 'Directory push.' {
        Choco-Push -Path ".\Testing" | Should -Be `
            $ShouldArray[1], $ShouldArray[-2], $ShouldArray[-1],`
            $ShouldArray[0], $ShouldArray[-2], $ShouldArray[-1]
    }

    It 'Recursive directory push.' {
        Choco-Push -Path ".\Testing" -Recurse | Should -Be `
            $ShouldArray[1], $ShouldArray[-2], $ShouldArray[-1],`
            $ShouldArray[0], $ShouldArray[-2], $ShouldArray[-1],`
            $ShouldArray[3], $ShouldArray[-2], $ShouldArray[-1],`
            $ShouldArray[2], $ShouldArray[-2], $ShouldArray[-1]
    }
}