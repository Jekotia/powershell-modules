function Expand-ChocolateyPackageFile_main {
	Param
    (
        [Parameter(Mandatory=$true)]
        [String]
		$Path,

        [Parameter(Mandatory=$true)]
        [String]
		$OutputDir,

        [Parameter(Mandatory=$true)]
        [String]
        $CopyZip
    )
	#$Debug = $true
	Write-Debug "Begin Expand-ChocolateyPackageFile_main"
	if (Test-Path "$($outputDir)") {
		Write-Error "$($outputDir) already exists. Refusing to continue."
		return #False
	} elseif (Test-Path "$($copyZip)") {
		Write-Error "$($copyZip) already exists. Refusing to continue."
		return #false
	} else {
		Write-Output "Copying $Path to $copyZip"
		Copy-Item -Path "$($Path)" -Destination "$($copyZip)"
		if ($?) {
			Write-Debug "Creating output directory $outputDir"
			New-Item -ItemType Directory -Path "$($outputDir)"
			if ($?) {
				Write-Debug "Unpacking $name.nupkg as $copyZip..."
				Expand-Archive -Path "$($copyZip)" -DestinationPath "$($outputDir)"
				if ($?) {
					Write-Debug "Removing extraneous files from extraction target"
					Remove-Item `
						-Recurse `
						-Path `
							"$($outputDir)\package", `
							"$($outputDir)\_rels", `
							"$($outputDir)\``[Content_Types``].xml"
					if ($?) {
						Write-Output "Successfully unpacked $name"
					} else {
						Write-Error "Failed to remove extraneous files from extraction target"
					}
				} else { Write-Error "Failed to unpack $name.nupkg as $copyZip" }
			} else { Write-Error "Failed to create output directory $outputDir" }
		} else { Write-Error "Failed to copy $name.nupkg to $copyZip" }
	}
	Write-Debug "End Expand-ChocolateyPackageFile_main" ; return #False
}
function Expand-ChocolateyPackageFile_cleanup {
	Param
    (
        [Parameter(Mandatory=$true)]
        [String[]]
        $CopyZip
    )
	Write-Debug "Begin Expand-ChocolateyPackageFile_cleanup"
	if (Test-Path "$($copyZip)") {
		Remove-Item -Path "$($copyZip)"
	}
	Write-Debug "End Expand-ChocolateyPackageFile_cleanup" ; return #False
}
function Expand-ChocolateyPackageFile {
	Param
    (
        [Parameter(Mandatory=$true)]
        [String[]]
		$Path,

        [Parameter(Mandatory=$false)]
        [String[]]
		$Target
    )
	#$Debug = $true
	Write-Debug "Begin Expand-ChocolateyPackageFile"
	if (dir $Path | select Extension | select-string "nupkg") {
		Write-Debug "File is .nupkg"
		$name = dir "$($Path)" | select BaseName
		$name = "$($name.BaseName)"
		Write-Debug "Package name is $name"

		if ([string]::IsNullOrEmpty($target)) {
			$outputDir = ".\$($name)-unpacked"
			Write-Output "No target has been provided. Using: $outputDir"
			
		} else {
			$outputDir = "$($target)\$($name)-unpacked"
			Write-Debug "Target has been provided, using: $target."
		}
		
		Write-Debug "output directory is $outputDir"
		$copyZip = ".\.temp-$($name).zip"
		Write-Debug "Temporary zip file is $copyZip"

		Expand-ChocolateyPackageFile_main "$($Path)" "$($outputDir)" "$($copyZip)"
		Expand-ChocolateyPackageFile_cleanup "$($copyZip)"
	} else {
		Write-Error "$($Path) does not appear to be a .nupkg file. Refusing to continue."
		Write-Debug "End Expand-ChocolateyPackageFile" ; return #False
	}
	Write-Debug "End Expand-ChocolateyPackageFile" ; return #False
}

New-Alias -Name 'Choco-Unpack' -Value 'Expand-ChocolateyPackageFile'

Export-ModuleMember -Function 'Expand-ChocolateyPackageFile' -Alias 'Choco-Unpack'