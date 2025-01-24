#!/bin/bash

# Root directory with videos or subdirectories with videos
root_dir="/mnt/i/Victor/Directory/DirectoryWithVideos" # SETUP YOUR FOLDER HERE

# Control file to stop the script
control_file="/tmp/compress_videos_control"
# Log file to track the script
log_file="/tmp/compress_videos.log"

# Function to process videos
process_videos() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            process_videos "$file"
        elif [[ "$file" == *.mp4 || "$file" == *.mkv ]]; then
            # Check if the file is already processed (ends with "_c")
            if [[ "$file" == *_c.mp4 ]]; then
                echo -e "\nSkipping already processed file: $file"
                continue
            fi

            output_file="${file%.*}_c.mp4"
            echo -e "\n============================================================================================================"
            echo -e "Processing: $file -> $output_file"
            echo -e "============================================================================================================="

            ffmpeg -i "$file" -c:v h264_nvenc -preset fast -b:v 5M -r 60 -c:a aac -b:a 128k "$output_file" 2>&1 | tee "$log_file"

            # Show the current status and overall progress
            echo -e "\nLast ffmpeg logs:"
            tail -n 10 "$log_file" | grep -E 'Error|frame|time='

            if [ $? -eq 0 ]; then
                # If compression is successful
                echo -e "\nCompression successful. Deleting original file: $file"
                rm "$file"
            else
                echo -e "\nError compressing $file. Original file will not be deleted."
            fi
        fi

        # Check the control file to see if the script should stop
        if [ -f "$control_file" ]; then
            echo -e "\nStopping execution as requested."
            exit 0
        fi
    done
}

stop_script() {
    touch "$control_file"
    echo -e "\nControl file created. The script will stop after the current process."
}

remove_control_file() {
    rm -f "$control_file"
}

trap stop_script SIGINT
trap remove_control_file EXIT
process_videos "$root_dir"
