# Flutter Riverpod Template

![version](https://img.shields.io/badge/version-0.0.4-blue)

A modern Flutter project template designed for scalability and rapid development. This template comes pre-configured with Riverpod for state management, a clean architecture, and a focus on best practices.

## ✨ Features

- **State Management**: Pre-configured with [Riverpod](https.riverpod.dev) for robust and scalable state management.
- **Clean Architecture**: Follows a clear and maintainable project structure, separating concerns into `data`, `domain`, and presentation layers.
- **Dependency Injection**: Integrated dependency injection for managing services and dependencies.
- **Theming**: Implements modern Material Design 3 theming for a consistent and visually appealing UI.
- **Linting**: Strict linting rules to ensure code quality and consistency.
- **Cross-Platform**: Supports iOS, Android, and web platforms out of the box.
- **Screen Util**: Responsive UI for different screen sizes.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- An IDE with Flutter support (VS Code, Android Studio, or IntelliJ)

### Installation

1.  **Clone the repository**:

    ```bash
    git clone https://github.com/rahul-gola/flutter_riverpod_template.git
    ```

2.  **Install dependencies**:

    ```bash
    flutter pub get
    ```

3.  **Run the application**:

    ```bash
    flutter run
    ```

## 📂 Project Structure

```
flutter_riverpod_template/
├── android/
├── ios/
├── web/
├── lib/
│   ├── core/           # Core utilities, DI, and base classes
│   ├── main.dart       # App entry point
│   └── src/            # Presentation layer (UI)
│       ├── home/       # Home feature
│       ├── my_app/     # Main app widget and routing
│       ├── splash_screen/ # Splash screen
│       └── widget/     # Common widgets
├── data/               # Data layer (repositories, data sources)
├── domain/             # Domain layer (entities, use cases)
├── assets/             # Static assets (images, fonts)
└── pubspec.yaml        # Project dependencies and configuration
```

