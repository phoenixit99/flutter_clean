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

lib/
├── data/
│   ├── models/
│   ├── repositories/
│   ├── datasources/
├── domain/
│   ├── entities/
│   ├── usecases/
│   ├── repositories/
├── presentation/
│   ├── bloc/
│   ├── widgets/
│   ├── screens/

Key Concepts in BLoC

	1.	Events:
	•	Represent user actions or triggers in the app.
	•	Examples: Button press, API call, etc.
	2.	States:
	•	Represent the current state of the UI.
	•	Examples: Loading, Loaded, Error, etc.
	3.	Bloc:
	•	The business logic layer that maps events to states.
	4.	Repository:
	•	Handles data-related tasks like API calls or database interactions.
	5.	BlocProvider:
	•	Injects the Bloc into the widget tree so it can be accessed by descendants.
