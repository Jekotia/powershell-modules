function Get-ConfigDownload {
    $Config = Import-Configuration

    $Config = Merge-Hashtables $Config.Default $Config.Download
    return $Config
}