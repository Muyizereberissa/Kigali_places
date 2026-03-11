# Kigali City Services Directory App

## Overview
The Kigali City Services Directory App is a Flutter mobile application that allows users to find important services in Kigali such as hospitals, libraries, police stations, and other public places.

Users can create and manage listings, view detailed information about services, and navigate to locations using Google Maps.

---

## Features

### User Authentication
- Users can **sign up** using email and password.
- Users can **log in** to access the application.
- Firebase Authentication is used to manage user accounts.

### Listings Management
Users can manage service listings through the app:
- **Create listings** by adding service details.
- **Edit listings** they created.
- **Delete listings** from the database.

### Search and Filter
- Users can **search listings by name**.
- Users can **filter listings by category**.

### Listing Details
Each listing has a detail page that displays:
- Name
- Category
- Address
- Contact information
- Description
- Location on the map

### Map and Navigation
- The listing detail page shows the **location on an embedded map**.
- Users can press the **Navigate button** to open Google Maps for directions.

---

## Firestore Database Structure

The application uses **Firebase Firestore** as the database.

A collection called **places** stores all listings.

Each document contains the following fields:

| Field | Description |
|------|-------------|
| name | Name of the place |
| category | Type of service (hospital, library, police station, etc.) |
| address | Physical address |
| contact | Contact information |
| description | Details about the place |
| latitude | Latitude coordinate |
| longitude | Longitude coordinate |
| createdBy | ID of the user who created the listing |

The **createdBy** field allows the app to show only the listings created by the logged-in user in the **My Listings** page.

---

## State Management

The application uses **Provider** for state management.

A class called **PlaceProvider** manages the list of places in the application. It handles:

- Fetching listings from Firestore
- Adding new listings
- Updating listings
- Deleting listings

The provider listens for changes and updates the UI using `notifyListeners()`.

---

## Technologies Used
- Flutter
- Firebase Authentication
- Firebase Firestore
- Provider (State Management)
- Google Maps