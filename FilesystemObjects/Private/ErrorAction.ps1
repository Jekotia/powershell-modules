function ErrorAction ($Default, $BoundParameters) {
    if ( $BoundParameters.ContainsKey('ErrorAction') ) {
        return $ErrorActionPreference
    } else {
        return $Default
    }
}