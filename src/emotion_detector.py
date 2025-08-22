import argparse
import os
import sys
import time
from typing import Tuple, List

import cv2
import numpy as np
import onnxruntime as ort
import requests

# Model configuration
MODEL_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", ".models")
MODEL_PATH = os.path.join(MODEL_DIR, "fer_plus.onnx")
# A commonly mirrored lightweight FER+ style model. If this URL fails, user can replace via --model-path
MODEL_URL = "https://github.com/onnx/models/raw/main/vision/body_analysis/emotion_ferplus/model/emotion-ferplus-8.onnx"

# Expected class order for FER+ (8 emotions)
# Reference labels used by many FER+ implementations
FERPLUS_LABELS = [
	"neutral",
	"happiness",
	"surprise",
	"sadness",
	"anger",
	"disgust",
	"fear",
	"contempt",
]

TARGET_EMOTIONS = {"anger", "sadness", "happiness"}  # we'll render happiness as "smile"


def ensure_model(model_path: str, model_url: str) -> None:
	os.makedirs(os.path.dirname(model_path), exist_ok=True)
	if os.path.isfile(model_path) and os.path.getsize(model_path) > 0:
		return
		
	print(f"Downloading model to {model_path} ...")
	r = requests.get(model_url, timeout=60)
	r.raise_for_status()
	with open(model_path, "wb") as f:
		f.write(r.content)
	print("Model downloaded.")


def softmax(logits: np.ndarray) -> np.ndarray:
	exp = np.exp(logits - np.max(logits, axis=-1, keepdims=True))
	return exp / np.sum(exp, axis=-1, keepdims=True)


def preprocess_face(face_bgr: np.ndarray) -> np.ndarray:
	"""Preprocess face crop to 1x1x64x64 float32 suitable for FER+ model."""
	gray = cv2.cvtColor(face_bgr, cv2.COLOR_BGR2GRAY)
	resized = cv2.resize(gray, (64, 64), interpolation=cv2.INTER_AREA)
	# Normalize to [0,1], then standardize to [-1,1]
	norm01 = resized.astype(np.float32) / 255.0
	norm11 = (norm01 - 0.5) / 0.5
	# Shape to NCHW: (1,1,64,64)
	input_blob = norm11[np.newaxis, np.newaxis, :, :].astype(np.float32)
	return input_blob


def pick_emotion(probabilities: np.ndarray) -> Tuple[str, float]:
	idx = int(np.argmax(probabilities))
	label = FERPLUS_LABELS[idx]
	prob = float(probabilities[idx])
	return label, prob


def draw_label(frame: np.ndarray, text: str, x: int, y: int, color: Tuple[int, int, int]) -> None:
	cv2.putText(frame, text, (x, max(0, y - 10)), cv2.FONT_HERSHEY_SIMPLEX, 0.7, color, 2, cv2.LINE_AA)


def main() -> None:
	parser = argparse.ArgumentParser(description="Webcam Emotion Detector (anger, sadness, smile)")
	parser.add_argument("--camera-index", type=int, default=0, help="OpenCV camera index (default 0)")
	parser.add_argument("--min-size", type=int, default=90, help="Minimum face size in pixels")
	parser.add_argument("--confidence", type=float, default=0.4, help="Minimum probability to display label")
	parser.add_argument("--model-path", type=str, default=MODEL_PATH, help="Path to ONNX model")
	parser.add_argument("--model-url", type=str, default=MODEL_URL, help="URL to download model if missing")
	args = parser.parse_args()

	ensure_model(args.model_path, args.model_url)

	providers = ["CPUExecutionProvider"]
	session = ort.InferenceSession(args.model_path, providers=providers)
	input_name = session.get_inputs()[0].name
	output_name = session.get_outputs()[0].name

	# Haar cascade for face detection
	face_cascade_path = cv2.data.haarcascades + "haarcascade_frontalface_default.xml"
	if not os.path.isfile(face_cascade_path):
		print("Could not find Haar Cascade at:", face_cascade_path)
		sys.exit(1)
	face_cascade = cv2.CascadeClassifier(face_cascade_path)

	cap = cv2.VideoCapture(args.camera_index)
	if not cap.isOpened():
		print(f"Error: Could not open camera index {args.camera_index}")
		sys.exit(1)

	last_fps_time = time.time()
	frame_count = 0
	fps = 0.0

	try:
		while True:
			ret, frame = cap.read()
			if not ret:
				print("Warning: Failed to read frame from camera")
				break

			gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
			faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(args.min_size, args.min_size))

			for (x, y, w, h) in faces:
				face_bgr = frame[y:y+h, x:x+w]
				input_blob = preprocess_face(face_bgr)
				outputs = session.run([output_name], {input_name: input_blob})[0]
				probs = softmax(outputs[0])
				label, prob = pick_emotion(probs)

				if label in TARGET_EMOTIONS and prob >= args.confidence:
					shown_label = "smile" if label == "happiness" else label
					color = (0, 200, 0) if shown_label == "smile" else ((0, 0, 255) if shown_label == "anger" else (255, 0, 0))
					cv2.rectangle(frame, (x, y), (x+w, y+h), color, 2)
					draw_label(frame, f"{shown_label}: {prob:.2f}", x, y, color)
				else:
					# Draw neutral box lightly (optional)
					cv2.rectangle(frame, (x, y), (x+w, y+h), (128, 128, 128), 1)

			# FPS overlay
			frame_count += 1
			now = time.time()
			if now - last_fps_time >= 1.0:
				fps = frame_count / (now - last_fps_time)
				frame_count = 0
				last_fps_time = now
			cv2.putText(frame, f"FPS: {fps:.1f}", (8, 24), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 255), 2, cv2.LINE_AA)

			cv2.imshow("Emotion Detection (q to quit)", frame)
			if cv2.waitKey(1) & 0xFF == ord('q'):
				break
	finally:
		cap.release()
		cv2.destroyAllWindows()


if __name__ == "__main__":
	main()