# This script takes a quoted input, usually a single line string error stack, 
# and converts it into a quickly readable format by making general assumptions
# on how it should be parsed.
#
# It can also make URL parameters easier to see
#
# Sometimes info stacks come in different formats, such as using : for a new item. These can be added as encountered here,
# but be aware this could interfere with previous things such as httpS: url having an extra newline. 

$INPUT=$args[0]

#whitespace
$FORMATTED=($INPUT) -replace '\\n',"`n"

#URLS
$FORMATTED=($INPUT) -replace ' http',"`nhttp"
$FORMATTED=($INPUT) -replace '\?',"`n   ?"
$FORMATTED=($INPUT) -replace '\&',"`n    &"

#Error stacks
#$FORMATTED=($INPUT) -replace ' at ',"`n at " #Disabled as this may not work for all error stacks strings, such as if it's already formatted

#other misc formats
$FORMATTED=($INPUT) -replace '\:',"`n  :"

#terminal output
cls
Write-Host "----- START -----"
Write-Host @"
$FORMATTED
"@
Write-Host "----- END   -----"

