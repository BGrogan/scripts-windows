$input_video_name = $args[0]
if ($input_video_name -eq $null -OR $input_video_name -eq "") {
	write-host "Argument error!
	Please specify a single video file. Did not find anything at ($input_video_name).
	Only the individual video will be processed in this script."
	exit
}

$output = $input_video_name + "_ffmpeg.mp4" 
ffmpeg -i "$input_video_name" -codec:v libx264 -preset ultrafast -force_key_frames "expr:gte (t,n_forced*4)" -hls_time 4 -hls_playlist_type vod -hls_segment_type mpegts $output