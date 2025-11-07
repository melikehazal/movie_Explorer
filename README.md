# 🎬 Movie Explorer App

Discover, search, and save your favorite movies — all in one Flutter app!

---

## 🚀 Features

✅ **Popular, Trending, and Upcoming Movies**
Get real-time lists of what’s hot and what’s coming soon.

✅ **Discover Section 🎲**
Explore random movie suggestions every time you visit the tab.

✅ **Search Functionality 🔍**
Quickly find any movie from the TMDB database.

✅ **Movie Details Page 🎞️**
See posters, ratings, and overviews with a clean UI.

✅ **Favorites ❤️ (Hive Integration)**
Save your favorite movies locally — even offline!

✅ **State Management with Provider**
All screens react smoothly to changes, no manual refresh needed.

---

## 🛠️ Tech Stack

| Layer            | Technology                                             |
| ---------------- | ------------------------------------------------------ |
| Frontend         | Flutter (Dart)                                         |
| State Management | Provider                                               |
| Local Storage    | Hive                                                   |
| API              | TMDB (The Movie Database)                              |
| Architecture     | Clean MVC-ish structure (services, providers, widgets) |

---

## 📁 Folder Structure

```
lib/
│
├── models/
│   └── movie_model.dart
│
├── providers/
│   ├── movie_provider.dart
│   └── favorites_provider.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── detail_screen.dart
│   └── favorites_screen.dart
│
├── services/
│   └── api_service.dart
│
├── widgets/
│   ├── movie_card.dart
│   ├── search_bar.dart
│   └── movie_list_tab.dart
│
└── main.dart
```

---

## ⚙️ Setup Instructions

1️⃣ Clone the repo

```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/movie_explorer_flutter.git
cd movie_explorer_flutter
```

2️⃣ Install dependencies

```bash
flutter pub get
```

3️⃣ Add your TMDB API key

- Open: `lib/services/api_service.dart`
- Replace with your own API key
  ```dart
  final String apiKey = "YOUR_TMDB_API_KEY";
  ```

4️⃣ Run the app

```bash
flutter run
```

---

## 🌐 API Reference

This app uses [The Movie Database (TMDB)](https://developer.themoviedb.org/reference/intro/getting-started) API.
Endpoints used:

- `/movie/popular`
- `/movie/upcoming`
- `/trending/movie/week`
- `/discover/movie`
- `/search/movie`

---

## 📸 Screenshots

| Home                         | Discover                         | Favorites                         |
| ---------------------------- | -------------------------------- | --------------------------------- |
| ![](assets/screens/home.png) | ![](assets/screens/discover.png) | ![](assets/screens/favorites.png) |

---

## ✨ Future Improvements

- Add genre-based filtering
- Add movie trailers (YouTube API)
- Light/Dark mode toggle
- Implement Firebase auth for user profiles

---
