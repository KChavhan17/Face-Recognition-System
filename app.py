from flask import Flask, request, jsonify, render_template
import numpy as np
import cv2 as cv
import os
import joblib
import face_recognition as fr
import base64
from io import BytesIO
from matplotlib import pyplot as plt

# -----------------------------
# Flask App Initialization
# -----------------------------
app = Flask(__name__)

# -----------------------------
# Load Trained KNN Model
# -----------------------------
MODEL_PATH = "./model/knn_face_recognition_model.pkl"
knn_model = joblib.load(MODEL_PATH)
print("✅ KNN Face Recognition model loaded successfully!")

# -----------------------------
# Utility Function: Display Image (for internal use)
# -----------------------------
def show_image(image, x=10, y=8, bgr=False):
    plt.figure(figsize=(x, y))
    if len(image.shape) == 2:
        plt.imshow(image, cmap='gray')
    elif len(image.shape) == 3:
        if bgr:
            image = cv.cvtColor(image, cv.COLOR_BGR2RGB)
        plt.imshow(image)
    plt.xticks([])
    plt.yticks([])
    plt.show()

# -----------------------------
# Core Prediction Function
# -----------------------------
def predict_and_visualize(image_path, output_dir="./static/results"):
    os.makedirs(output_dir, exist_ok=True)

    image = cv.imread(image_path)
    rgb_image = cv.cvtColor(image, cv.COLOR_BGR2RGB)
    image_height, image_width = image.shape[:2]

    face_locations = fr.face_locations(rgb_image)
    face_encodings = fr.face_encodings(rgb_image, face_locations)

    results = []

    for (top, right, bottom, left), face_encoding in zip(face_locations, face_encodings):
        distances, _ = knn_model.kneighbors([face_encoding], n_neighbors=1)
        distance = distances[0][0]
        confidence = round(float(1 - distance), 3)
        name = knn_model.predict([face_encoding])[0] if distance < 0.5 else "Unknown"

        cv.rectangle(image, (left, top), (right, bottom), (0, 255, 0), 2)
        font_scale = image_width / 700.0
        text_position = (left, bottom + int(image_height * 0.04))
        cv.putText(image, f"{name} ({confidence})", text_position, cv.FONT_HERSHEY_DUPLEX, font_scale, (0, 255, 0), 2)

        results.append({"name": name, "confidence": confidence})

    # Save annotated image with unique name
    filename = f"annotated_{np.random.randint(100000)}.jpg"
    output_path = os.path.join(output_dir, filename)
    cv.imwrite(output_path, image)

    # Return only the relative path (Flask static)
    return {"predictions": results, "annotated_image_path": f"/static/results/{filename}"}

# -----------------------------
# Routes
# -----------------------------
@app.route('/')
def home():
    return render_template('index.html')  # optional upload form

@app.route('/predict', methods=['POST'])
def predict():
    try:
        if 'image' not in request.files:
            return jsonify({"error": "No image file found in the request"}), 400

        file = request.files['image']
        temp_path = "./temp_image.jpg"
        file.save(temp_path)

        result = predict_and_visualize(temp_path)
        os.remove(temp_path)

        return jsonify(result)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

# -----------------------------
# Run Flask App
# -----------------------------
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
