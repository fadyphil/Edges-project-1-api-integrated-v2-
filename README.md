# Culinary Companion v2 (API Integrated)

> **The Evolution: From Local Data to Remote Data Sources**

This repository represents the **second iteration** of my recipe application. While [v1](https://github.com/fadyphil/Edges-project-1) focused on mastering State Management (BLoC), **v2** focuses on real-world data handling, **REST API integration**, and robust error handling.

---

## ⚡ What's New in v2?

| Feature | v1 (Previous) | v2 (This Repo) |
| :--- | :--- | :--- |
| **Data Source** | Hardcoded Local Data | **Remote REST API** |
| **Networking** | None | **Dio / HTTP Client** |
| **Error Handling** | Basic Validation | **Http Exceptions & Server Failures** |
| **Serialization** | Manual / None | **JSON Serialization** |

---

## 🛠 Tech Stack Upgrades

* **Networking:** [`dio`](https://pub.dev/packages/dio) (with Interceptors for logging)
* **State Management:** `flutter_bloc` (handling Async Loading/Success/Failed states)
* **Architecture:** Clean Architecture with **Repository Pattern**
    * `RemoteDataSource`: Fetches raw JSON.
    * `Repository`: Converts Exceptions to `Failures` (Either type).
    * `Bloc`: Maps Failures to UI States.

---

## 📸 API Integration Demo

<p align="center">
  <img src="https://via.placeholder.com/220x400?text=API+Loading+State" width="220" />
  <img src="https://via.placeholder.com/220x400?text=Live+Data+Feed" width="220" />
</p>

---

## 💻 Code Highlight: The Repository Pattern

This project implements a strict **Repository Pattern** to decouple the UI from the data source. If the API fails, the UI never crashes; it simply receives a structured `Failure` object.

```dart
// Example of how v2 handles API calls safely
Future<Either<Failure, List<Recipe>>> getRecipes() async {
  try {
    final response = await apiProvider.get('/recipes');
    return Right(Recipe.fromJsonList(response.data));
  } on DioException catch (e) {
    return Left(ServerFailure.fromDioError(e));
  } catch (e) {
    return Left(UnknownFailure());
  }
}
````

-----

## 📂 Folder Structure (Data Layer)

The structure has been expanded to support networking:

```text
lib/
├── core/
│   └── error/         # Custom Failures & Exceptions
├── data/
│   ├── datasources/   # RemoteDataSource (Dio calls)
│   ├── models/        # JSON Models (fromJson/toJson)
│   └── repositories/  # Repository Implementation
├── domain/            # Entities & UseCases
└── presentation/      # BLoC & UI
```

## 🔌 Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/fadyphil/Edges-project-1-api-integrated-v2-.git](https://github.com/fadyphil/Edges-project-1-api-integrated-v2-.git)
    ```
2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the App:**
    ```bash
    flutter run
