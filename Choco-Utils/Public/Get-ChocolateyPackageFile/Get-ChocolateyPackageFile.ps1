function Get-ChocolateyPackageFile {
    Param (
        [Parameter(Mandatory=$true)]
        [string[]]
        $Packages,
        [Parameter(Mandatory=$false)]
        [string]
        $Path
    )

    $DownloadConfig = Get-ConfigDownload

    Write-Debug "BEGIN ChocoDownload"
    # Ensure package name has been provided
    if ([string]::IsNullOrEmpty($Packages)) {
        Write-Error "No package provided."
        return
    }

    # Create packages array
    $PackageList = $Packages.split(",")
    
    # Loop
    foreach ($Package in $PackageList) {
        Write-Output "Package: $Package"
        $PackageSplit = $Package.Split("@")
        
        $PackageName = $PackageSplit[0]
        $PackageVersion = $PackageSplit[1]
        
        
        
        if ([string]::IsNullOrEmpty($PackageVersion)) {
            $URL = "$($DownloadConfig.Source)/$($PackageName)"
        } else {
            $URL = "$($DownloadConfig.Source)/$($PackageName)/$($PackageVersion)"
        }


        Write-Debug "URL: $URL"
        Get-FileFromURL -URL "$URL" -Path "$Path"

        # Clear variables for clean looping
        #sleep 2
    }
    Write-Debug "End ChocoDownload" ; return
}

New-Alias `
    -Name Choco-Download `
    -Value Get-ChocolateyPackageFile

Export-ModuleMember `
    -Function Get-ChocolateyPackageFile `
    -Alias Choco-Download