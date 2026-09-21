# 👤 AI Face Recognition System using Face Embeddings & KNN

An end-to-end **AI-powered Face Recognition System** built using **Python, Flask, OpenCV, face_recognition, and Scikit-learn**. The application identifies known individuals from uploaded images by extracting facial embeddings and matching them against a trained **K-Nearest Neighbors (KNN)** model.

---

# 📖 Project Overview

Face Recognition has become one of the most widely used applications of Artificial Intelligence and Computer Vision, powering solutions in authentication, attendance systems, surveillance, and access control.

This project demonstrates a complete AI-based face recognition application where users can upload an image containing one or multiple faces. The system automatically detects faces, generates facial embeddings, compares them with previously learned identities using a trained KNN classifier, and returns the predicted identity along with a confidence score.

If a detected face does not sufficiently match any known individual, it is classified as **Unknown**.

---

# 🎬 Project Demonstration

Watch the complete project walkthrough on YouTube:

**https://youtu.be/O3IqMDZ8uvo?si=NkIOJXzUAJsF3ZJH**

---

# ✨ Features

* 👤 Face Recognition from uploaded images
* 📸 Automatic face detection
* 🧠 Face embedding generation using the `face_recognition` library
* 🤖 Identity prediction using a trained K-Nearest Neighbors (KNN) classifier
* 📊 Confidence score for every detected face
* 🟩 Automatic annotation with bounding boxes and predicted names
* 👥 Supports multiple faces in a single image
* ❓ Automatically labels unknown individuals
* 🌐 Flask-based web application
* ☁️ Ready for cloud deployment

---

# 🏗️ Recognition Workflow

```text
           Upload Image
                 │
                 ▼
          Face Detection
                 │
                 ▼
      Face Embedding Extraction
                 │
                 ▼
      K-Nearest Neighbors (KNN)
                 │
                 ▼
      Identity Prediction
                 │
                 ▼
 Bounding Boxes + Confidence Score
                 │
                 ▼
      Annotated Image Output
```

---

# 🛠️ Technology Stack

## Backend

* Python
* Flask
* OpenCV
* NumPy
* Joblib

## Artificial Intelligence

* face_recognition
* dlib
* Scikit-learn
* K-Nearest Neighbors (KNN)

## Frontend

* HTML5
* CSS3
* JavaScript

---

# 📂 Project Structure

```text
Face-Recognition-System/
│
├── model/
│   └── knn_face_recognition_model.pkl
│
├── static/
│   ├── results/
│   └── ...
│
├── templates/
│   └── index.html
│
├── app.py
├── requirements.txt
├── README.md
└── ...
```

---


# 🔮 Future Enhancements

* Real-time webcam face recognition
* Face registration through the web interface
* Attendance management integration
* Face mask detection
* Anti-spoofing (liveness detection)
* REST API support
* Docker deployment
* Cloud deployment (AWS, Azure, GCP)
* GPU acceleration for faster inference

---

# 🤝 Contributions

Contributions, suggestions, and feature enhancements are welcome. Feel free to fork the repository and submit a Pull Request.

---

# 👨‍💻 Author

**Mandeep Kharb**

If you found this project useful, consider giving it a ⭐ on GitHub.

---

# 📄 License

This project is intended for educational, research, and learning purposes. It is not designed for production-grade identity verification or security-critical authentication systems.
