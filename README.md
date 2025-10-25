# Product Catalog Flutter App

A clean, scalable Flutter application that displays a product catalog using **BLoC state management**, **Dio** for API calls, and **Hive** for offline caching.

## 📱 Features

- ✅ Fetch product list from FakeStore API
- ✅ Display products in a clean 2-column Grid UI
- ✅ Show product image, title, price, category, and rating
- ✅ Cache product data locally using Hive
- ✅ Offline support - loads cached data when API fails
- ✅ Clean Architecture with BLoC pattern
- ✅ Pull-to-refresh functionality
- ✅ Error handling with user-friendly messages
- ✅ Loading states and offline indicators

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                           # Core utilities
│   ├── error/
│   │   └── exceptions.dart         # Custom exceptions
│   └── network/
│       └── dio_client.dart         # HTTP client wrapper
├── data/                           # Data layer
│   ├── models/
│   │   └── product_model.dart      # JSON serialization model
│   ├── data_sources/
│   │   ├── product_remote_data_source.dart  # API calls
│   │   └── product_local_data_source.dart   # Hive operations
│   └── repositories/
│       └── product_repository_impl.dart     # Repository implementation
├── domain/                         # Business logic layer
│   ├── entities/
│   │   └── product.dart            # Core business entity
│   ├── repositories/
│   │   └── product_repository.dart # Repository interface
│   └── usecases/
│       └── get_products.dart       # Business use case
├── presentation/                   # UI layer
│   ├── bloc/
│   │   ├── product_bloc.dart       # BLoC logic
│   │   ├── product_event.dart      # BLoC events
│   │   └── product_state.dart      # BLoC states
│   ├── screens/
│   │   └── product_screen.dart     # Main screen
│   └── widgets/
│       └── product_card.dart       # Reusable product card
├── injection_container.dart        # Dependency injection setup
└── main.dart                       # App entry point
```

## 🔄 Data Flow

```
UI (Widget) 
    → Event (LoadProductsEvent)
        → BLoC (ProductBloc)
            → UseCase (GetProductsUseCase)
                → Repository (ProductRepositoryImpl)
                    → Remote DataSource (API) OR Local DataSource (Hive)
                        → Model → Entity
                            → State (ProductLoaded)
                                → UI Update
```

## 📦 Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.6      # State management
  equatable: ^2.0.5         # Value equality
  dio: ^5.4.3+1             # HTTP client
  hive: ^2.2.3              # Local database
  hive_flutter: ^1.1.0      # Hive Flutter integration
  get_it: ^7.7.0            # Dependency injection
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / VS Code
- An emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd product_catalog_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🎯 Key Implementation Details

### BLoC Pattern

- **Events**: `LoadProductsEvent`, `RefreshProductsEvent`
- **States**: `ProductInitial`, `ProductLoading`, `ProductLoaded`, `ProductError`
- **BLoC**: Handles business logic and state transitions

### Offline Support

The app automatically handles offline scenarios:
1. Tries to fetch from API first
2. On success, caches data locally
3. On failure (network/server), loads from cache
4. Shows offline indicator when using cached data

### Error Handling

- Network errors (timeout, no connection)
- Server errors (4xx, 5xx)
- Cache errors (no cached data)
- User-friendly error messages

### Dependency Injection

Uses GetIt for service locator pattern:
- DioClient (HTTP client)
- Data sources (remote & local)
- Repository
- Use case
- BLoC

## 🎨 UI Features

- **AppBar**: "Product Catalog" title with refresh button
- **Grid Layout**: 2 columns with responsive sizing
- **Product Card**: 
  - Product image with loading/error states
  - Product title (max 2 lines)
  - Category badge
  - Price in green
  - Star rating
- **Pull-to-Refresh**: Swipe down to refresh
- **Loading State**: Progress indicator with message
- **Error State**: Error icon with retry button
- **Offline Indicator**: Orange banner when showing cached data

## 🔧 Customization

### Change API Endpoint

Edit `lib/core/network/dio_client.dart`:
```dart
baseUrl: 'https://your-api-endpoint.com',
```

### Modify Cache Duration

Customize cache behavior in `lib/data/repositories/product_repository_impl.dart`

### Styling

Update theme in `lib/main.dart`:
```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  // Add your custom theme
)
```

## 🧪 Testing

Run tests:
```bash
flutter test
```

## 📱 Screenshots

The app displays:
- Clean grid layout with product cards
- Product images with proper aspect ratio
- Category badges
- Prices and ratings
- Responsive design

## 🛠️ Troubleshooting

### Issue: Dependencies not installing
```bash
flutter clean
flutter pub get
```

### Issue: Hive errors
```bash
# Clear app data/cache on device
flutter run --clear-cache
```

### Issue: Network errors in debug
- Check internet connection
- Verify API endpoint is accessible
- Check certificate validation (for HTTPS)

## 📝 Code Quality

- ✅ Null safety enabled
- ✅ Const constructors where applicable
- ✅ Final variables
- ✅ Meaningful naming conventions
- ✅ Comprehensive comments
- ✅ Separation of concerns
- ✅ SOLID principles

## 🔮 Future Enhancements

- [ ] Add product detail screen
- [ ] Implement search functionality
- [ ] Add filter by category
- [ ] Add favorites feature
- [ ] Add animations
- [ ] Unit tests
- [ ] Integration tests

## 📄 License

This project is created for educational purposes.

## 👨‍💻 Author

Built with ❤️ using Flutter & BLoC

---

**API Source**: [FakeStore API](https://fakestoreapi.com/)


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
