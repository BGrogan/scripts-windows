$input_file = $args[0]
if ($input_file -eq $null -OR $input_file -eq "") {
	write-host "Argument error!
	Please specify the single audio file as the argument.
	Ex: 123.mp3"
	exit
}

$image_name_for_video_so_youtube_doesnt_complain="image.png"
if (!(Test-Path -Path .\$image_name_for_video_so_youtube_doesnt_complain -PathType Leaf)) {
	write-host "Missing setup file!
	$image_name_for_video_so_youtube_doesnt_complain could not be found at this location. 
	The script is checking from the location the script is run and expecting this file to be right there.
	Please create it as a placeholder file so it qualifies as a video for YouTube."
	exit
}

#Actual processing:
$outfile = $input_file + "_ffmpeg.mp4"
ffmpeg -loop 1 -framerate 2 -i $image_name_for_video_so_youtube_doesnt_complain -i $input_file -c:v libx264 -preset medium -tune stillimage -crf 18 -c:a copy -shortest -pix_fmt yuv420p $outfile
