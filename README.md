# Repository Manager

## General Architecture of the Application

The Repository Manager application is built using Flutter, leveraging the Provider package for state management and Shared Preferences for local data storage. The application features a user-friendly interface that allows users to browse trending repositories, mark them as favorites, and view their list of favorite repositories.

## Reasoning Behind Main Technical Choices

- **Provider**: This state management solution simplifies data sharing between widgets and reactivity, keeping the UI in sync with underlying data changes.

- **Shared Preferences**: For local storage of favorite repositories, Shared Preferences offers a simple key-value storage solution, making it easy to persist data without a complex setup.

- **Cached Network Images**: Implementing image caching with the `cached_network_image` package helps improve performance and reduce network usage by caching avatar images.

## Features Not Implemented

While the application is functional, there are several features that were not implemented or could be improved for a production version:

- Search Functionality.
- Error Handling.
- Offline Support.


