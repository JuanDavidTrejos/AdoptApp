<p align="center">
  <img src="assets/icon/logo_adoptapp.png" alt="AdoptApp Logo" width="120"/>
</p>

<h1 align="center">🐾 AdoptApp</h1>

<p align="center">
  <em>Adopta amor, cambia una vida.</em>
</p>

<p align="center">
  A modern, Tinder-style pet adoption mobile app built with Flutter & Firebase — connecting people with rescue animals through an intuitive swipe-to-adopt experience.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-2.19+-0175C2?logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-FFCA28?logo=firebase&logoColor=black" alt="Firebase"/>
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green" alt="Platform"/>
  <img src="https://img.shields.io/badge/License-MIT-blue" alt="License"/>
</p>

---

## 📖 About

**AdoptApp** is a mobile application designed to simplify and modernize the pet adoption process. Inspired by the swipe mechanic of dating apps, it lets users browse adoptable pets from verified foundations and shelters with a fun, engaging interface. The app also serves as a hub for adoption events and foundation directories — all powered by Firebase on the backend.

> Built as part of the *Seminario 1* course project at **Universidad Nacional de Colombia — Sede Medellín**.

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| **Tinder-style Pet Swiping** | Browse pets one at a time — like ❤️, super-like ⭐, or pass ✕ with intuitive action buttons |
| **Multi-step Registration** | 3-step onboarding flow (personal info → pet preferences → account setup) with progress tracking |
| **Firebase Authentication** | Secure email/password sign-up and login with real-time password validation |
| **Cloud Firestore** | User profiles and pet preferences persisted in Firestore with server timestamps |
| **Adoption Events** | Browse verified adoption events, view details, and register as a foster home or individual adopter |
| **Foundation Directory** | Discover verified animal rescue organizations with ratings, stats, and contact options |
| **Social Feed** | Instagram-style home feed with filter chips and post cards from shelters |
| **User Profiles** | View and manage personal information, pet preferences, and account settings |
| **Multi-role Support** | Supports Adoptante, Refugio, Rescatista, and Veterinario user types |

---

## 📱 Screenshots & Navigation Flow

```
SplashScreen (3s) ──▶ WelcomeScreen
                          │
              ┌───────────┴───────────┐
              ▼                       ▼
       Registration (3 steps)     Login Screen
              │                       │
              └───────┐   ┌───────────┘
                      ▼   ▼
                  HomeFeedScreen
              ┌───┬───┼───┬───┐
              ▼   ▼   ▼   ▼   ▼
            Feed Events Swipe Orgs Profile
```

### Screen Previews

| Splash & Welcome | Registration Flow | Main Experience |
|:-:|:-:|:-:|
| Animated splash with branding | 3-step progressive onboarding | Swipe, explore, adopt |
| Red gradient + heart-paw logo | Personal info → Preferences → Account | Bottom nav with 5 tabs + FAB |

---

## 🏗️ Architecture

```
lib/
├── main.dart                  # App entry point, Firebase init, MaterialApp config
├── firebase_service.dart      # Firebase Auth + Firestore service layer
└── screens/
    ├── Opening.dart           # Animated splash screen
    ├── pantalla_inicio.dart   # Welcome / landing page
    ├── inicio_sesion.dart     # Login screen
    ├── registro1.dart         # Registration Step 1 — Personal info
    ├── registro2.dart         # Registration Step 2 — Pet preferences
    ├── registro3.dart         # Registration Step 3 — Password & legal
    ├── pantalla_principal.dart# Main shell with bottom navigation
    ├── tinder_adoptapp.dart   # Tinder-style pet swiping
    ├── eventos.dart           # Adoption events listing
    ├── resumen_evento.dart    # Event detail & registration
    ├── fundaciones.dart       # Foundation directory
    └── perfil_usuario.dart    # User profile management
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| **Framework** | Flutter 3.x (Dart 2.19+) |
| **Authentication** | Firebase Authentication (Email/Password) |
| **Database** | Cloud Firestore |
| **State Management** | StatefulWidget (built-in) |
| **UI** | Material Design 3, custom gradients & animations |
| **Fonts** | Lobster (branding), Roboto (body) |
| **Platform** | Android & iOS |

---

## 🎨 Design System

### Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| 🔴 Coral Light | `#FF7B7B` | Gradient start, backgrounds |
| 🔴 Red Primary | `#E53E3E` | Gradient end, CTA buttons |
| 🔴 Accent Red | `#FF4757` | Profile header, highlights |
| 🟢 Verified Green | `#4CAF50` | Verified badges, success states |
| ⚪ Light Pink | `#FFF0F0` | Card backgrounds |
| ⚪ White | `#FFFFFF` | Cards, surfaces |

### Design Patterns
- **Card-based UI** with rounded corners (12–24px radius)
- **Gradient CTAs** — coral-to-red gradient buttons throughout
- **White card over gradient** — auth screens use elevated white cards on red gradient backgrounds
- **Custom page transitions** — slide + fade animations (400ms)
- **Progress indicators** — linear progress bars across registration steps (30% → 60% → 90%)

---

## 🗄️ Data Model

### Firestore — `users` Collection

```json
{
  "uid": "firebase-auth-uid",
  "name": "string",
  "lastName": "string",
  "email": "string",
  "phone": "string",
  "birthDate": "string",
  "userType": "Adoptante | Refugio | Rescatista | Veterinario",
  "petPreferences": {
    "petType": "Perros | Gatos | Conejos | Aves",
    "size": "Pequeño | Mediano | Grande",
    "ages": ["Cachorro", "Joven", "Adulto", "Anciano"],
    "characteristics": ["Juguetón", "Tranquilo", "Sociable", "Independiente", "Activo", "Cariñoso"]
  },
  "createdAt": "Timestamp (server)"
}
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or later)
- [Dart](https://dart.dev/get-dart) (2.19+)
- [Firebase CLI](https://firebase.google.com/docs/cli) configured
- Android Studio / Xcode for emulators
- A Firebase project with **Authentication** and **Cloud Firestore** enabled

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/AdoptApp.git
cd AdoptApp

# 2. Install dependencies
flutter pub get

# 3. Configure Firebase
#    - Add your own google-services.json (Android) to android/app/
#    - Add your own GoogleService-Info.plist (iOS) to ios/Runner/
#    - Enable Email/Password auth in Firebase Console
#    - Create a Firestore database

# 4. Run the app
flutter run
```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## 🗺️ Roadmap

- [ ] Integrate real pet data from Firestore
- [ ] Implement Google & Facebook social login
- [ ] Add real-time chat between adopters and foundations
- [ ] Push notifications for new pets matching preferences
- [ ] Image upload for user profiles
- [ ] Geolocation-based pet search
- [ ] Favorites / saved pets list
- [ ] Admin panel for foundations to manage listings
- [ ] Localization (English / Spanish)

---

## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

Developed with ❤️ as a university project at **Universidad Nacional de Colombia — Sede Medellín**

---

<p align="center">
  <strong>⭐ If you like this project, give it a star on GitHub! ⭐</strong>
</p>
