# MergePS Directives
MergePS directives are comments in your source files that instruct MergePS to preform certain actions. All MergePS directives are in the format of `##MergePS <ACTION>:<PARAMETERS>`. 

There are two primary categories of directives: Line & LineEnd.
## Line Directives
Line directives are written as the sole contents of the line they are on.

### RAW
This directive will insert the raw text that follows it, without any additional processing.

Example: `##MergePS RAW: $ManualConfig = 'config.psd1'`

### IMPORT
This directive will process and import the contents of the destination file.

Example: `##MergePS IMPORT: .\config.psd1`

### IMPORT RAW
This directive will import the contents of the destination file without processing it.

Example: `##MergePS IMPORT RAW: .\ui.xaml`

## LineEnd Directives
LineEnd directives are written at the end of a line. They are used to instruct MergePS to operate on the existing line.

### REMOVE