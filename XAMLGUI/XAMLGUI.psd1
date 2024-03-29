﻿@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'XAMLGUI'

    # Version number of this module.
    ModuleVersion = '1.0.0'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID = '9d76485b-2aee-421a-b999-dd9783448a10'

    # Author of this module
    Author = 'Josh "Jekotia" Ameli'

    # Company or vendor of this module
    CompanyName = 'Jekotia.net'

    # Copyright statement for this module
    Copyright = ''

    # Description of the functionality provided by this module
    Description = @'
Derived from https://foxdeploy.com/2015/04/16/part-ii-deploying-powershell-guis-in-minutes-using-visual-studio/

Imports XAML used in WPF as a GUI for PowerShell.
    
Usage:
    Load XAML:
        Import-XAMLGUI (Get-Content -Path "$PSScriptRoot\VSUI_4\MainWIndow.xaml")
            OR
        Import-XAMLGUI $InputXML

    Examples:
        Adding items to a dropdown/combo box
            $vmpicklistView.items.Add([pscustomobject]@{'VMName'=($_).Name;Status=$_.Status;Other="Yes"})

        Setting the text of a text box to the current PC name    
            $XAMLGUI_textBox.Text = $env:COMPUTERNAME

        Adding code to a button, so that when clicked, it pings a system
         $XAMLGUI_button.Add_Click({ Test-connection -count 1 -ComputerName $XAMLGUI_textBox.Text
         })
        

    Show the form:
        Initialize-XAMLGUI
'@

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
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        'Import-XAMLGUI',
        'Initialize-XAMLGUI'
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    FileList = @(
        'XAMLGUI.psd1',
        'XAMLGUI.psm1',
        'Public\Import-XAMLGUI.ps1',
        'Public\Initialize-XAMLGUI.ps1'
    )

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/Jekotia/powershell-modules/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/Jekotia/powershell-modules/tree/master/XAMLGUI'

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


