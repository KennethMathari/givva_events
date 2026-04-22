# GivvaEvents

A professional-grade Flutter application built as a takeaway assignment for Givva Wealthtech. This project demonstrates a clean implementation of a "Fund Collection Events" screen with paginated data and BLoC state management.

## 🚀 Features

- **Tabbed Navigation**: Separate tabs for Community, Subgroup, and Archived events.
- **Independent State Management**: Each tab maintains its own pagination and loading state independently.
- **Dynamic Status Logic**: 
  - `archivedAt != null` → **Archived** (Purple)
  - `closedAt != null` → **Closed** (Orange)
  - Otherwise → **Active** (Green)
- **Pagination**: Interactive "Previous", "Next", and numbered page buttons.
- **Modern UI**: Soft gradient background (Yellow-Green to Pink) and custom "pill" tab indicators.
- **Safe Area Integration**: Fully optimized for modern devices with bottom navigation bars.

## 🛠 Architecture

- **BLoC Pattern**: Used for predictable state management.
- **Clean Layers**:
  - `data/models`: Strongly typed data objects.
  - `data/mock`: Simulated API data.
  - `data/repositories`: Simulated data fetching with network latency.
  - `logic/bloc`: Business logic for event handling and state transitions.
  - `presentation`: Reusable widgets and screen layouts.

## 📦 Getting Started

### Prerequisites
- Flutter SDK (Channel stable)
- Android SDK / Xcode (for mobile development)

### Installation

1. **Clone the repository** (if applicable):
   ```bash
   git clone <repository-url>
   cd givva_events
   ```

2. **Get dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

## 🧪 Testing

The project includes unit, BLoC, and widget tests to ensure the reliability of business logic and UI components.

### Running Tests
To run all tests in the project:
```bash
flutter test
```

### Key Test Areas
- **Unit Tests**: Verifying data model parsing and repository simulation logic.
- **BLoC Tests**: Using `bloc_test` to verify state transitions (Loading -> Success/Error) for each event.
- **Widget Tests**: Ensuring core UI elements like `FundraiserCard`, `PaginationControls`, and `StatusChip` render correctly.

## 🔄 CI/CD Pipeline

The project uses **GitHub Actions** to automate quality checks and ensure a stable codebase.

### Workflow: `GivvaEvents CI`
The pipeline is triggered on every `push` and `pull_request` to the `main` branch. It performs the following steps:

1.  **Environment Setup**: Configures the Flutter SDK (stable channel).
2.  **Dependency Management**: Executes `flutter pub get` to fetch required packages.
3.  **Code Formatting**: Verifies that the code adheres to Dart formatting standards (`dart format`).
4.  **Static Analysis**: Runs `flutter analyze` to check for linting issues and potential bugs.
5.  **Test Suite**: Executes all automated tests via `flutter test` to prevent regressions.

## 📄 Mock Data
The app uses local mock data to simulate a real-world API response, including pagination metadata and an 800ms simulated network delay.

## Screenshots

<p align="center">
  <img src="Screenshot_20260421_011029.jpg" width="32%" />
  <img src="Screenshot_20260421_011019.jpg" width="32%" />
  <img src="Screenshot_20260421_011007.jpg" width="32%" />
</p>