# Emotion Detection (Anger, Sadness, Smile)

A lightweight, cross-platform (Linux/Windows) webcam emotion detector using OpenCV and an ONNX model.

- Detects: anger, sadness, smile (mapped from happiness)
- Runs on CPU via ONNX Runtime
- Uses your default webcam

## Prerequisites
- Python 3.9+ recommended
- A working webcam

## Install
```bash
# Optionally create a venv
python -m venv .venv
# Linux/macOS
source .venv/bin/activate
# Windows (PowerShell)
# .venv\Scripts\Activate.ps1

pip install -r requirements.txt
```

## Run
```bash
python -m src.emotion_detector
```

- Press `q` to quit.
- If you have multiple cameras, try `--camera-index 1` etc.

## Windows tips
- If the window is black, ensure camera permissions are enabled for Python in Windows Privacy settings.
- If you installed multiple Python versions, verify you are running the interpreter where dependencies were installed.

## Linux tips
- If you see camera permission errors, ensure your user is in the `video` group.
- On Wayland, OpenCV windows generally work; if they do not, try an X11 session or update OpenCV.

## CLI options
```bash
python -m src.emotion_detector --camera-index 0 --min-size 100 --confidence 0.5
```

## How it works
- Uses a small FER-ish ONNX model expecting grayscale 64x64 face crops.
- Face detection via OpenCV Haar Cascade.
- We map the model's `happiness` output to `smile` and filter to the three target emotions.

## Notes
- First run will automatically download the model into `.models/`.
- This project is CPU-only. No GPU required.