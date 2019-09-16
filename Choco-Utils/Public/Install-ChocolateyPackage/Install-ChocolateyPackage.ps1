function Install-ChocolateyPackage {
    Param
    (
        [Parameter(Mandatory=$true)]
        [String[]]
		$package,
        [Parameter(Mandatory=$false)]
        [String[]]
        $arguments
    )

    $InstallConfig = Get-ConfigInstall

	#$test = choco update --source="$($chocoSource)"
	#if ( $test | select-string "The specified source $($chocoSource) is not secure." ) {
	#	Show-Info "Source is insecure. Re-trying with --force"
		choco install $($package) --source="$($InstallConfig.Source)" $arguments
	#} else {
	#	choco push $($package) --source="$($chocoSource)"
	#}
}

New-Alias -Name 'Choco-Install' -Value 'Install-ChocolateyPackage'

Export-ModuleMember -Function 'Install-ChocolateyPackage' -Alias 'Choco-Install'
