# 📚 SmartLibrary — Digital Library App

<p align="center">
  <img src="https://img.icons8.com/fluent/144/000000/library.png" alt="Project Logo" width="120">
  <br>
  <b>UKL (Level Advancement Test) Project · Semester 1 · SMK Telkom Malang</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Status-Learning--Project-orange?style=for-the-badge" alt="Status">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-Apache%202.0-blue?style=flat-square" alt="License">
  <img src="https://img.shields.io/badge/architecture-MVC-purple?style=flat-square" alt="Architecture">
  <img src="https://img.shields.io/badge/platform-Android%20%7C%20iOS-lightgrey?style=flat-square" alt="Platform">
</p>

---

## 📖 Table of Contents

- [About the Project](#-about-the-project)
- [Features](#-features)
- [Project Architecture](#-project-architecture)
- [Reflections & Learning Notes](#-reflections--learning-notes)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Author](#-author)
- [License](#-license)

---

## 🔍 About the Project

**SmartLibrary** is a modern digital library application built with dedication as a **UKL (Level Advancement Test) project for Semester 1** at **SMK Telkom Malang**.

This project bridges aesthetic design with structured Dart programming logic — demonstrating that even at an early learning stage, clean architecture and functional user experience can be achieved simultaneously.

> *"Every line of code is a step toward mastery."*

---

## 🔥 Features

| Feature | Description |
|---------|-------------|
| 🔐 **Smart Authentication** | Smooth transition flow from Splash Screen through a complete Login & Register system |
| 📖 **Book Management** | Browse a popular book collection with interactive star ratings |
| ⚡ **Real-time Simulation** | Responsive book stock status indicators — **In Stock** / **Borrowed** |
| 📥 **Dynamic Input** | Add new books to the collection directly via an Interactive Bottom Sheet |
| 🌓 **Adaptive UI** | Full Dark Mode support for a comfortable, eye-friendly reading experience |

---

## 🛠️ Project Architecture

This application applies a clear **separation of concerns** using the **MVC (Model-View-Controller)** pattern, making the codebase more readable, maintainable, and scalable.

```
lib/
├── ⚙️  controllers/    # Business logic (Auth, Book, Borrow)
├── 📄  models/         # Data blueprints & object mapping
├── 🎨  theme/          # UI styling & theme management
├── 🖼️  views/          # Core application screens
└── 🧩  widgets/        # Reusable UI components
```

---

## 📝 Reflections & Learning Notes

> [!IMPORTANT]
> This project represents my first deep dive into the Flutter ecosystem.

As a first-semester student, I came to understand that building an application is not just about crafting a visually appealing interface — it is equally about solid logic, disciplined code structure, and thoughtful user flow design.

### What I Learned

- Fundamentals of the **Dart** programming language
- **Flutter Widget hierarchy** and layout management (`Row`, `Column`, `Stack`, `ListView`)
- Simulating data flow using a **local dummy database**
- Implementing the **MVC pattern** for structured project organization

### Current Limitations

This project currently relies on **local static data** and has not yet been integrated with a cloud database such as Firebase. I am aware of several areas that still require improvement, including stricter input validation and future API integration.

That said, this project proves that with persistence and curiosity, complex concepts can be transformed into a working, functional application — and it serves as an important foundation for everything that comes next.

---

## 🛠 Tech Stack

| Tool | Purpose |
|------|---------|
| **Flutter** | Cross-platform mobile UI framework |
| **Dart** | Core programming language |
| **MVC Pattern** | Architectural structure for separation of concerns |
| **Local / Dummy Data** | Static data simulation (no backend yet) |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed and configured
- A connected device or emulator (Android / iOS)
- Git

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/WagyuuA5/project_UKL_Perpustakaan_Digital.git
   cd project_UKL_Perpustakaan_Digital
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the application:**

   ```bash
   flutter run
   ```

> For a release build: `flutter build apk` (Android) or `flutter build ios` (iOS)

---

## 👤 Author

**Wahyu Ravi Anggoro** — [@WagyuuA5](https://github.com/WagyuuA5)
Student at **SMK Telkom Malang** · 2026

---

## 📄 License

Copyright © 2026 **Wahyu Ravi Anggoro**. All rights reserved.

This project is licensed under the **Apache License, Version 2.0** (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at:

> http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

---

<p align="center">
  <i>"Building reliable digital solutions through curiosity and persistence."</i>
  <br><br>
  Made with ❤️ by Wahyu Ravi Anggoro &nbsp;|&nbsp; SMK Telkom Malang &nbsp;|&nbsp; 2026
</p>
