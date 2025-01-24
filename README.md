## About the Project
**CudaCompressor** is a Bash script designed to automate the compression of video files in directories and subdirectories. It leverages NVIDIA's NVENC encoder for fast and efficient video compression while maintaining good video quality.

The script also includes:
- Automatic detection of already processed files to avoid redundancy.
- Real-time logs and progress updates during video compression.
- A control mechanism to stop the script safely.

---

## Features
- **Recursive Compression**: The first reason I thought to create this script. It processes all videos in a directory and its subdirectories.
- **NVENC Support**: Utilizes GPU acceleration for faster processing.
- **Automatic Logs**: Tracks all operations in a log file.
- **File Control**: Safely stops the script using a control file or via interruption.
- **Customizable Compression Settings**: Easily modify FFmpeg parameters for bitrate, presets, and more.

---

## System Requirements
### Operating System
- Ubuntu 22.04 or later (or any compatible Linux-based system). Compa

### Software Dependencies
- **FFmpeg**: Install FFmpeg with NVENC support.
  ```bash
  sudo apt update
  sudo apt install ffmpeg
  ```
- **NVIDIA Driver and CUDA Toolkit**:
  Ensure your system has the NVIDIA driver and CUDA installed:
  ```bash
  sudo apt install nvidia-driver-xxx
  sudo apt install nvidia-cuda-toolkit
  ```
  Replace `xxx` with your specific NVIDIA driver version.

### File Access
- Ensure the target video directory is mounted and accessible (e.g., `/mnt/f/Clipes/2022-2024`).
  For WSL users, configure WSL to access Windows drives.

### Permissions
- Make the script executable:
  ```bash
  chmod +x /path/to/compress_videos.sh
  ```

---

## Usage Instructions
### Run the Script
Navigate to the directory where the script is located and execute:
```bash
./compress_videos.sh
```

### Stop the Script
- To safely stop the script, press `Ctrl+C`.
- Alternatively, create the control file (`/tmp/compress_videos_control`):
  ```bash
  touch /tmp/compress_videos_control
  ```
  The script will halt after processing the current file.

### Adjust Compression Settings
- Modify `ffmpeg` parameters inside the script to adjust video quality and compression speed.
  Example:
  ```bash
  ffmpeg -i "$file" -c:v h264_nvenc -preset fast -b:v 5M -r 60 -c:a aac -b:a 128k "$output_file"
  ```
  - **`-preset fast`**: Adjust encoding speed (e.g., `slow`, `medium`, `fast`).
  - **`-b:v 5M`**: Set video bitrate (adjust to control file size and quality).
  - **`-r 60`**: Set frame rate.

---

## File Structure
- **compress_videos.sh**: Main script file.
- **/tmp/compress_videos.log**: Log file generated during execution.
- **/tmp/compress_videos_control**: Control file to stop the script.

---

## Example of Execution
1. Start the script:
   ```bash
   ./compress_videos.sh
   ```
2. View logs in real-time (optional):
   ```bash
   tail -f /tmp/compress_videos.log
   ```

---


## Contributing
Contributions are welcome! I've created this script just to solve an issue from another compressing software that was annoying me. Feel free to submit issues or pull requests to improve the script.

---

## Disclaimer
This script assumes a functional NVIDIA GPU with NVENC support. For non-NVIDIA systems, you may need to adapt the script to use CPU encoding.

