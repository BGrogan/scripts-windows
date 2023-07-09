$input_video_name = $args[0]
if ($path_to_files_to_process -eq $null -OR $path_to_files_to_process -eq "") {
	write-host "Argument error!
	Please specify a single video file. 
	Only this one video will be processed in this script."
	exit
}

$output = $input_video_name_ffmpeg + "_ffmpeg.mp4" 
ffmpeg -i "$input_video_name" -codec:v libx264 -preset ultrafast -force_key_frames "expr:gte (t,n_forced*4)" -hls_time 4 -hls_playlist_type vod -hls_segment_type mpegts $output