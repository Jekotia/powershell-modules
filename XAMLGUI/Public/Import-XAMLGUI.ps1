# FROM https://foxdeploy.com/2015/04/16/part-ii-deploying-powershell-guis-in-minutes-using-visual-studio/

function Import-XAMLGUI {
    Param (
        #[Alias("XAMLPath")]
        [Parameter(Mandatory=$true)]
        #[ValidateNotNullOrEmpty()]
        #[SupportsWildcards()]
        #[string]
        $inputXML
    )
    #Import XAML from file
    #$Global:inputXML = (Get-Content -Path "$Path")
    
    #Replace strings which would be invalid in PowerShell
    $inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window'
    [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
    [xml]$XAML = $inputXML

    #Read XAML
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
    try{
        $Global:Form=[Windows.Markup.XamlReader]::Load( $reader )
    }
    catch{
        Write-Warning "Unable to parse XML, with error: $($Error[0])`n Ensure that there are NO SelectionChanged or TextChanged properties in your textboxes (PowerShell cannot process them)"
        throw
    }
    
    #===========================================================================
    # Load XAML Objects In PowerShell
    #===========================================================================
    
    $xaml.SelectNodes("//*[@Name]") |
        ForEach-Object {
            if ($Global:Debug) {
                "trying item $($_.Name)";
            }
            try {
                Set-Variable -Scope Global -Name "XAMLGUI_$($_.Name)" -Value $Global:Form.FindName($_.Name) -ErrorAction Stop
            }
            catch{
                throw
            }
        }
    
    Function Get-FormVariables{
        if ($ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$ReadmeDisplay=$true}
        write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
        get-variable XAMLGUI_*
    }
    
    if ($Global:Debug) {
        Get-FormVariables
    }

}

#Export-ModuleMember -Function Import-XAMLGUI