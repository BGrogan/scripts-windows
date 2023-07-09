$path_to_files_to_process = $args[0]
if ($path_to_files_to_process -eq $null -OR $path_to_files_to_process -eq "") {
	write-host "Argument error!
	Please specify a location in the argument. 
	All files in this location should be videos only, and they will all be processed."
	exit
}

$confirmation = Read-Host -Prompt "Are you sure you want convert ALL files in this location? ($path_to_files_to_process) [y]"
if ($confirmation -eq 'y') {
	#Just get all files here and load into object
	$files = Get-ChildItem "$path_to_files_to_process"

	#To display progress
	$counter = 0

	foreach ($f in $files){
		#Only for displaying progress:
		$counter++
		Write-Progress -Activity 'Converting Videos' -CurrentOperation $f -PercentComplete (($counter / $files.count) * 100)
		# write-host "Processing $f of $files.count"

		#Actual processing:
		$outfile = $f.FullName + "_ffmpeg.mp4" 
		# libx264 and h264_nvenc are both good codec options
		ffmpeg -i "$f" -codec:v libx264 -preset ultrafast -force_key_frames "expr:gte (t,n_forced*4)" -hls_time 4 -hls_playlist_type vod -hls_segment_type mpegts "$outfile"
	}
} else {
	write-host "Exiting"
	exit
}

# For reference incase this is needed in a bat script, here's the original batch script that did this before converting to powershell/ps1
# @rem for file in */*;do ffmpeg -i "$file" -c:v h264_nvenc "$file".mp4;done

# @rem ffmpeg -i input.mp4 -vcodec libx265 -crf 28 output.mp4

# for %%f in (*.MOV) do (
# 	echo %%~nf

# 	@rem ffmpeg -i "%%~nf.mov" -vcodec libx265 -crf 28 "%%~nf.mp4"
# 	ffmpeg -i "%%~nf.mov" -c:v h264_nvenc "%%~nf.mp4"
# 	@rem libx264

# 	@REM ffmpeg -i "%%~nf.jpg" "%%~nf.png"
# @REM del "%%
