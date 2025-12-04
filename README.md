# Union Shop - Flutter E-Commerce Application

A modern e-commerce mobile application built with Flutter for the University of Portsmouth Student Union shop. This project recreates the functionality of shop.upsu.net as a coursework submission for Programming Applications and Programming Languages (M30235) and User Experience Design and Implementation (M32605).

## Features Implemented

### Core Features
- Homepage - Hero section with product grid and navigation
- Collections - Browse product collections with search, sort, and filter capabilities
- Products - Detailed product pages with size/color selection and quantity controls
- Shopping Cart - Full cart management with persistent storage
- Search - Global product search accessible from navbar and footer
- Sale Items - Dedicated page for discounted products
- Print Shack - Custom product personalization with live preview
- About Page - Company information and details
- Authentication UI - Login and signup forms (UI only)

### Technical Highlights
- State Management - Provider pattern for cart state
- Persistent Storage - Cart data saved locally using SharedPreferences
- Responsive Design - Adaptive layouts for mobile, tablet, and desktop (3/2/1 column grids)
- Dynamic Routing - Support for parameterized routes (e.g., /collection/:id)
- Mock Data Services - ProductService, CollectionService, CartService with 8 products and 4 collections
- Network Image Handling - Graceful error fallbacks for missing images
- Widget Testing - Comprehensive test suite covering key pages and services

## Project Structure

lib/ contains: components/ (navbar.dart, footer.dart, product_card.dart), constants/ (app_constants.dart), data/ (mock_data.dart), models/ (product.dart, collection.dart, cart.dart, cart_item.dart), pages/ (home_page.dart, collections_page.dart, collection_detail_page.dart, product_page.dart, cart_page.dart, search_page.dart, sale_page.dart, print_shack_page.dart, about_page.dart, login_page.dart, signup_page.dart), services/ (product_service.dart, collection_service.dart, cart_service.dart), and main.dart

test/ contains: home_test.dart, product_test.dart, pages/cart_page_test.dart, and services/cart_service_test.dart

## Getting Started

### Prerequisites
- Flutter SDK (>=2.17.0 <4.0.0)
- Dart SDK
- An IDE with Flutter support (VS Code, Android Studio, or IDX)

### Installation

1. Clone the repository: git clone https://github.com/YOUR-USERNAME/union_shop.git then cd union_shop

2. Install dependencies: flutter pub get

3. Run the application: flutter run
   For web: flutter run -d chrome

### Running Tests

Run all tests: flutter test

Run specific test file: flutter test test/home_test.dart

Run tests with coverage: flutter test --coverage

## Dependencies

### Core
- flutter - UI framework
- provider (^6.1.5+1) - State management
- shared_preferences (^2.2.3) - Local data persistence

### Development
- flutter_test - Testing framework
- flutter_lints (^2.0.0) - Code quality analysis

## Key Implementation Details

### State Management
The app uses Provider for managing cart state across the application. CartService extends ChangeNotifier and is provided at the app root in main.dart. This allows any widget to access cart state without prop drilling.

### Cart Persistence
Cart items are automatically saved to SharedPreferences on every change (add/remove/update quantity). On app startup, CartService restores the cart by deserializing product IDs and re-fetching full product data from ProductService. This ensures cart data survives app restarts while keeping product information up-to-date.

### Responsive Design
Pages use MediaQuery breakpoints for adaptive layouts: Wide screens (>900px) show 3 columns, medium screens (600-900px) show 2 columns, and mobile (<600px) shows 1 column. This applies to product grids in home, sale, collections, and search pages.

### Routing
The app uses named routes with onGenerateRoute for dynamic paths. Static routes include /, /collections, /cart, /search, /about, /sale, /login, /signup, /print-shack. Dynamic routes include /collection/:id and /product (with arguments).

### Mock Data
All product and collection data is defined in lib/data/mock_data.dart. No backend or database is required - services operate entirely in-memory with local persistence for cart only.

## Testing Strategy

Tests cover: Widget tests for UI rendering and user interactions on HomePage and ProductPage, Service tests for business logic in CartService (add/remove/update/clear operations), and Integration tests for CartPage functionality with Provider. All tests include proper Provider wrapping and handle async operations with pumpAndSettle().

## Known Limitations

- Authentication - Login/signup pages are UI-only (no backend integration)
- Payment - Checkout button displays a message but doesn't process payments
- Image Loading - Uses network images with error fallbacks; may fail in test environments
- External Services - No cloud services integrated (Firebase, APIs, etc.)

## Development Notes

### Git Workflow
This project follows a commit-per-feature workflow with clear, descriptive commit messages. Each feature is developed incrementally with regular commits to maintain project history. Example commits include: "Update tests to match current UI (home/product)", "Add search functionality to navbar and footer", "Persist cart locally with SharedPreferences", "Improve Print Shack with dynamic selectors and live preview".

### Code Style
- Follows Flutter/Dart style guide
- Uses flutter_lints for static analysis
- Consistent naming conventions (camelCase for variables, PascalCase for classes)

## Future Enhancements

Potential improvements for future versions: Firebase Authentication integration, real backend API with product database, payment gateway integration (Stripe, PayPal), user account dashboard and order history, product reviews and ratings, advanced filtering (multiple categories, price ranges), wishlist functionality, and email notifications.

## Credits

Developer: [Your Name]
Institution: University of Portsmouth
Course: M30235 Programming Applications and Programming Languages
Academic Year: 2024-2025

## License

This project is created for educational purposes as part of university coursework.

Note: This is a demonstration project and not intended for production use. Product images and data are placeholder/mock content for educational purposes only.