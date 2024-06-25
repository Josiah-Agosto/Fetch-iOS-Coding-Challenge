# iOS Coding Challenge - Dessert Recipes

## Overview
This project is an iOS application that allows users to retrieve a list of dessert recipes, sort them alphabetically, and view detailed information about each meal, including its ingredients and instructions. The application is built using a mix of UIKit and SwiftUI to demonstrate proficiency in both frameworks and follows the Model-View-ViewModel (MVVM) architecture for a clean and maintainable codebase. The project does not have a team set (its set to none), this is to reduce any potential errors since its not going to be published on the App Store/Testflight, lastly since i was able to test through simulator. Enjoy reviewing!

## Features
- **Retrieve Dessert Recipes**: Fetch a list of dessert recipes from an external API.
- **Sorting**: Sort the list of desserts in both ascending and descending alphabetical order.
- **Lazy Loading**: Images are lazily loaded and cached to improve performance since there can be lots of images.
- **Detailed View of Meals**: View detailed information about a selected meal, including:
  - Meal Name and Thumbnail
  - Instructions
  - Ingredients and Measurements
  - Link to YouTube video (if available)
- **Search Functionality**: Search through the list of desserts to find specific recipes.
- **SwiftUI Integration**: Detailed meal views are implemented using SwiftUI for a modern UI experience.

## Technologies Used
- **UIKit**: Used for the main structure and navigation of the app.
- **SwiftUI**: Utilized for the detailed view of each meal.
- **Combine**: Reactive programming and handling asynchronous data streams.
- **XCTest**: Implemented unit tests to ensure the reliability and correctness of the app.

## Architecture
The application is built using the **Model-View-ViewModel (MVVM)** architecture, which helps in separating the business logic from the UI and ensures a clear, maintainable, and testable codebase.

## Project Structure
- **Home View**: Displays the list of dessert recipes and includes sorting and search functionalities.
- **Detail View**: Shows detailed information about a selected meal using SwiftUI.
- **View Models**: Handles the business logic and data manipulation for the views.
- **Networking Layer**: Responsible for making API calls to retrieve dessert data.
- **Unit Tests**: Comprehensive tests for view models and networking components to ensure proper functionality.
