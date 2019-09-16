function Get-ConfigPush {
    $Config = Import-Configuration

    $Config = Merge-Hashtables $Config.Default $Config.Push
    return $Config
}