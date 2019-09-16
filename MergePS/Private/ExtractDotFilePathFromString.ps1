function ExtractDotFilePathFromString {
    Param (
        # Help text
        [Parameter(Mandatory=$true)]
        [String]
        $Line
    )

    # Regex for finding the beginning and end points of the file path
    $RegexTerm = "(?:\`"|\`')"
    # Regex for finding and capturing the file path
    $Regex = "^\s*\.\s$RegexTerm(.*)$RegexTerm"

    # https://stackoverflow.com/a/7409187/1871306
    # Use a regex capture group to extract the file path from the input string $Line
    $DotFile = $Line -match $Regex

    # Check if the regex match was successful
    if ($DotFile) {
        # Set our variable to equal the contents of the first capture group
        $DotFile = $matches[1]
        return $DotFile
    } else {
        Write-Error "Unable to extract file path from string: $Line"
        return $false
    }
}