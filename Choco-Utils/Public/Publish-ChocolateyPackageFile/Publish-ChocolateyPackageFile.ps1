function Publish-ChocolateyPackageFile {
    Param
    (
        [Parameter(Mandatory=$true, ParameterSetName="Packages",Position=0)]
        [String[]]
		$Packages,
        [Parameter(Mandatory=$true, ParameterSetName="Path")]
        [String]
		$Path,
        [Parameter(Mandatory=$False, ParameterSetName="Path")]
        [Switch]
        $Recurse
	)

	$PushConfig = Get-ConfigPush

	if ( $PSBoundParameters.ContainsKey('Path') ) {
		Write-Debug "Path provided."
		$Path = "$Path".TrimEnd('\')
		if (Confirm-Directory "$Path") {
			if ( $PSBoundParameters.ContainsKey('Recurse') ) {
				Write-Debug "Recurse: true"
				$PackageList = Get-ChildItem -Path "$Path" -Filter "*.nupkg" -File -Name -Recurse | ForEach-Object { "$Path\$_" }
			} else {
				$PackageList = Get-ChildItem -Path "$Path" -Filter "*.nupkg" -File -Name | ForEach-Object { "$Path\$_" }
			}
		} else {
			Write-Error "Invalid directory provided: $Path"
		}
	} elseif ( $PSBoundParameters.ContainsKey('Packages') ) {
		Write-Debug "Packages provided."
		# Create packages array
		$PackageList = $Packages.split(",")
	}
	
	Write-Debug "PackageList: $packagelist"

	$SecureSource = choco push --source="$($PushConfig.Source)"
	if ( $SecureSource | select-string "The specified source `'$($PushConfig.Source)`' is not secure." ) {
		Write-Output "Source is insecure. Will use --force"
		$SecureSource = $false
	} else {
		Write-Debug "Secure source"
		$SecureSource = $true
	}

    # Loop
    foreach ($Package in $PackageList) {
        Write-Output "Package: $Package"
		if ($SecureSource) {
			choco push "$($package)" --source="$($PushConfig.Source)"
		} else {
			choco push "$($package)" --source="$($PushConfig.Source)" --force
		}
    }
}


New-Alias `
	-Name Choco-Push `
	-Value Publish-ChocolateyPackageFile

Export-ModuleMember `
	-Function Publish-ChocolateyPackageFile `
	-Alias Choco-Push