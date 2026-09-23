# MovieDB

An iOS Movie application built with **Swift** and **UIKit** using **MVVM architecture**. The app fetches movie data from the **TMDB API**, displays movies in a collection view, supports search, and provides a detailed view for each movie.

## Demo

<p align="center">
  <img src="Demo/moviedb-demo.gif" width="320" alt="MovieDB Demo">
</p>

## Features

* Fetches movies from the TMDB API
* Displays movies using `UICollectionView`
* Search movies by title
* Navigate to a movie details screen
* Asynchronous networking using `URLSession`
* JSON parsing using `Decodable`
* Image downloading and caching using `NSCache`
* Reusable custom collection view cells
* Programmatic UI with Auto Layout
* MVVM architecture
* Error handling
* Mock movie data for testing
* Unit testing using XCTest

## Architecture

The project follows the **MVVM architecture** to separate UI, presentation logic, and networking responsibilities.

```text
View
  ↓
ViewModel
  ↓
Network Service
  ↓
TMDB API
```

The ViewModel handles movie data and search logic while the ViewController focuses on displaying the UI and handling user interaction.

## Tech Stack

* Swift
* UIKit
* MVVM
* URLSession
* TMDB API
* Decodable
* NSCache
* UICollectionView
* Auto Layout
* XCTest

## Project Structure

```text
MovieDB
├── Model
├── View
├── ViewModel
├── Network
├── Extensions
├── Constants
└── Tests
```

## Networking

The app uses `URLSession` to fetch movie data from the **TMDB Discover API** and decodes the response into Swift models using `Decodable`.

Movie poster images are downloaded asynchronously and cached using `NSCache` to avoid unnecessary repeated network requests.

## Search

The app supports case-insensitive movie search by title. Clearing the search text restores the complete movie list.

## Movie Details

Selecting a movie navigates to `MovieDetailsViewController`, where information such as the movie title, poster, rating, release date, language, and overview is displayed.

## Testing

Unit tests are written using **XCTest** for important functionality and ViewModel behavior.

Mock movie data is also used to test the application without relying on live API responses.

## Getting Started

1. Clone the repository:

```bash
git clone https://github.com/Laasya-73/MovieDB.git
```

2. Open the project in Xcode.
3. Select an iOS Simulator or connected device.
4. Build and run the application.

## Requirements

* Xcode
* Swift
* iOS Simulator or physical iOS device

## Author

**Laasya Priya**

GitHub: [@Laasya-73](https://github.com/Laasya-73)
