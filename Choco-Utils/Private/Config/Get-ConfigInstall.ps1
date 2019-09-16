function Get-ConfigInstall {
    $Config = Import-Configuration

    $Config = Merge-Hashtables $Config.Default $Config.Install
    return $Config
}
