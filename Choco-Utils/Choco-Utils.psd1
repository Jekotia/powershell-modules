@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'Choco-Utils'

    # Version number of this module.
    ModuleVersion = '1.0.0'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID = '345e1eb8-9567-4f29-9fe5-ed761ba419f6'

    # Author of this module
    Author = 'Josh "Jekotia" Ameli'

    # Company or vendor of this module
    CompanyName = 'Jekotia.net'

    # Copyright statement for this module
    Copyright = 'Copyright (c) 2019 Josh "Jekotia" Ameli'

    # Description of the functionality provided by this module
    # Description = ''

    # Minimum version of the Windows PowerShell engine required by this module
    # PowerShellVersion = ''

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules = @(
        @{
            ModuleName="Assert-File";
            ModuleVersion="1.0";
            Guid="be1b32d0-35e0-4f92-8073-98be63d19070"
        },
        @{
            ModuleName="Configuration";
            ModuleVersion="1.3.1";
            Guid="e56e5bec-4d97-4dfd-b138-abbaa14464a6"
        }
    <#
        @{
            ModuleName="Get-FileFromURL";
            ModuleVersion="1.0";
            Guid="b1590f5c-6828-4fb0-9341-13092a062f2a"
        }
    #>
    )

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    <#NestedModules = @(
        'Expand-ChocolateyPackageFile\Expand-ChocolateyPackageFile.ps1',
        'Get-ChocolateyPackageFile\Get-ChocolateyPackageFile.ps1',
        'Install-ChocolateyPackage\Install-ChocolateyPackage.ps1',
        'Publish-ChocolateyPackageFile\Publish-ChocolateyPackageFile.ps1',
        'Config\Get-ConfigDownload.ps1'
    )#>

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        'Expand-ChocolateyPackageFile',
        'Get-ChocolateyPackageFile',
        'Install-ChocolateyPackage',
        'Invoke-ChocoUtils',
        'Publish-ChocolateyPackageFile'
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = @()

    # Variables to export from this module
    VariablesToExport = ''

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = @(
        'Choco-Download',
        'Choco-Install',
        'Choco-Push',
        'Choco-Unpack',
        'Choco-Utils'
    )

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    FileList = @(
        'Choco-Utils.psd1',
        'Choco-Utils.psm1',
        'Public\Expand-ChocolateyPackageFile\Expand-ChocolateyPackageFile.ps1',
        'Public\Get-ChocolateyPackageFile\Get-ChocolateyPackageFile.ps1',
        'Public\Install-ChocolateyPackage\Install-ChocolateyPackage.ps1',
        'Public\Publish-ChocolateyPackageFile\Publish-ChocolateyPackageFile.ps1',
        'Private\Config\Get-ConfigDownload.ps1'
        'Private\Config\Get-ConfigInstall.ps1'
        'Private\Config\Get-ConfigPush.ps1'
    )

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/Jekotia/powershell-modules/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/Jekotia/powershell-modules/tree/master/Choco-Utils'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}