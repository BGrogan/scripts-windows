$timestamp = $args[0]

# Test data / notes
#1687078690
#$result_seconds = ([System.DateTimeOffset]::FromUnixTimeSeconds($timestamp)).DateTime
#[datetimeoffset]::FromUnixTimeMilliseconds($timestamp).DateTime
#   [datetime]::fromunixtimemilliseconds($args[0])
# (([System.DateTimeOffset]::FromUnixTimeSeconds($timestamp)).DateTime).ToString("s")
#$result_milliseconds = [datetimeoffset]::FromUnixTimeMilliseconds($timestamp).DateTime

# Error validation / Determine if we should use seconds or milliseconds in the conversion:
if ($timestamp -eq $null){
	write-host -f red "  This script needs to be called with a 10 or 13 digit timestamp argument."
	exit
}

$timestamp_length = ($timestamp).ToString().Length #convert to string before .length otherwise it always returns 1

if ($timestamp_length -eq 13) { 
	$result = [datetimeoffset]::FromUnixTimeMilliseconds($timestamp).DateTime
} elseif ($timestamp_length -eq 10) { 
	$result = ([System.DateTimeOffset]::FromUnixTimeSeconds($timestamp)).DateTime
} else {
	write-host -f red "  Invalid timestamp ($timestamp). It appears as an unexpected length (at $timestamp_length characters) for it to be a seconds or milliseconds timestamp."
}


$result_local = $result.ToLocalTime()
$timezone_local = (Get-TimeZone).Id #Get-TimeZone | Select-Object Id #Get-TimeZone | Select-Object -First 1


# Breaks down output into multiple coding lines so text can utilize multiple colors, but the actual output is 1 line
write-host "  $timestamp ========== " -nonewline; 
write-host -ForegroundColor Green "$result" -nonewline; 
write-host " UTC ========== " -nonewline; 
write-host -ForegroundColor Green "$result_local " -nonewline;
write-host "$timezone_local"