# Sample BLoC Implementation in Flutter

This repository contains a sample implementation of the BLoC (Business Logic Component) pattern in a Flutter application. BLoC helps to separate business logic from the UI, making your code more manageable and testable.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Architecture Overview](#architecture-overview)
- [Usage](#usage)
- [Running the App](#running-the-app)
- [Contributing](#contributing)
- [License](#license)

## Features

- Simple counter application demonstrating BLoC pattern
- State management using streams
- Responsive UI

## Getting Started

To get started with this sample project, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/phoenixit99/flutter_clean.git
   cd flutter_clean 
   
2. Install dependencies: Ensure you have Flutter installed. Run the following command to get the required packages:
bash

 ```bash
flutter pub get 
```

Architecture Overview
The app uses the BLoC pattern to manage the state of a simple counter. The architecture consists of:

UI Layer: Flutter widgets that display the current count and buttons to increment/decrement.
BLoC Layer: Contains the business logic to manage the counter state.
Model Layer: Defines the data structure (in this case, the counter value).
Usage
To use the BLoC in your application:

Create a CounterBloc class that extends Bloc from the flutter_bloc package.
Define events and states for the BLoC.
Use the BLoC in your widget tree with BlocProvider and BlocBuilder. 

3. Project Structure 
```
lib/
├── data/
│   ├── models/          # Data models that represent API responses or database structures.
│   ├── repositories/    # Implementation of repositories that interact with data sources.
│   ├── datasources/     # Sources of data, such as APIs or local databases.
├── domain/
│   ├── entities/        # Core application entities (plain Dart objects, business rules).
│   ├── usecases/        # Business logic (one use case per file).
│   ├── repositories/    # Abstract definitions of repositories (implemented in the data layer).
├── presentation/
│   ├── bloc/            # BLoC (Business Logic Components) for managing UI states.
│   ├── widgets/         # Reusable UI components.
│   ├── screens/         # Screens for various parts of the app (e.g., Login, Home, Profile).
```
Explanation of Layers

1. Data Layer

	•	models/: Contains classes that represent data structures (e.g., JSON models for APIs or database schemas).
	•	datasources/: Defines where data comes from (e.g., remote APIs, local databases, or mock data).
	•	repositories/: Implements the domain repositories by combining data from data sources.

2. Domain Layer

	•	entities/: Defines core business objects used across the app. These are independent of the UI and data source.
	•	usecases/: Encapsulates specific application functionality, such as “Log in User” or “Fetch Profile Details.”
	•	repositories/: Abstract interfaces for repositories, implemented in the data layer.

3. Presentation Layer

	•	bloc/: Manages the application’s state and logic, handling user interactions and data flow.
	•	widgets/: Reusable UI components such as buttons, cards, or input fields.
	•	screens/: Complete screens/views for various parts of the app.
