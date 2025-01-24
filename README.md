# CudaCompressor

**CudaCompressor** is a Bash script that automates the compression of video files using NVIDIA's NVENC encoder for fast, efficient processing.

---

## Features
- **Recursive Compression**: Processes videos in a directory and subdirectories (the main reason I created this script).
- **NVENC Support**: GPU acceleration for faster compression.
- **Automatic Logs**: Tracks operations in a log file.
- **File Control**: Safely stops the script using a control file or interruption.
- **Customizable Settings**: Modify FFmpeg parameters for bitrate and presets.
  
---

## System Requirements
### Operating System
- Ubuntu 22.04 or later (or any compatible Linux-based system).

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
Contributions are welcome! I originally created this script to address an issue I encountered with another compression tool that was frustrating to use. Feel free to submit issues or pull requests to help improve the script.

---

## Disclaimer
This script requires a functional NVIDIA GPU with NVENC support. For non-NVIDIA systems, adapt the script for CPU encoding.
