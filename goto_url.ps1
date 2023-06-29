#ForEach-Object { Add-Content -Path ..\secrets.txt -Value "$_." }
$a = Get-Content -Path ..\secrets.txt

start chrome $a
#write-host "$a"