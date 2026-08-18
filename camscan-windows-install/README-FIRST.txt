camscan - Windows install

IMPORTANT: Extract this zip first. Do not run install-windows.bat by
double-clicking it while it's still inside the zip (Windows will only
copy that one file to a temp folder, and it'll fail).

1. Right-click camscan-windows-install.zip -> "Extract All..." -> choose
   a real folder (e.g. your Desktop) -> Extract.
2. Open that extracted folder. You should see three files:
   install-windows.bat, camscan-0.1.0-py3-none-any.whl, this file.
3. Double-click install-windows.bat.
4. Follow any prompts (it'll tell you if Python or ffmpeg are missing).
5. Open a new Command Prompt and run: camscan scan 192.168.1.0/24
