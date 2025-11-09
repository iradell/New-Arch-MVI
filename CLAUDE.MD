# MovieApp - iOS Project Documentation

## Project Overview

**MovieApp** is a modern iOS application implementing the **MVI (Model-View-Intent)** architecture pattern using SwiftUI. The project demonstrates clean architecture principles with a modular, framework-based structure separating concerns across Domain, Data, and Presentation layers.

**Platform:** iOS/iPadOS (SwiftUI)
**Architecture:** MVI (Model-View-Intent)
**Language:** Swift 5.9+
**Minimum iOS:** 17.0+ (uses @Observable macro)
**Total Files:** 36 Swift files (~800 lines of code)
**Status:** Active development, architecture complete, features in progress

## MVI Architecture Pattern

This project implements a unidirectional data flow pattern:

```
User Action (Intent) → ViewModel processes Intent → State Update → View Re-renders
                                    ↓
                              Side Effects (Navigation, etc.)
```

### Core MVI Components

#### 1. **Intent** - User Actions
```swift
enum MovieListViewModelIntent {
    case didSelectMovie
    case removeAll
}
```
- Enums defining all possible user interactions
- Passed to `handleIntent()` for processing
- Ensures predictable state changes

#### 2. **Model** - State & Data
```swift
struct MovieListViewModelState {
    var data: ViewModelState<MovieItemList>
}

enum ViewModelState<T> {
    case loading
    case success(T)
    case failure(Error)
}
```
- Reactive state using `@Observable` macro
- Generic state wrapper for loading/success/failure
- Immutable domain models

#### 3. **View** - UI Layer
```swift
struct MovieListView<ViewModel: MovieListViewModel>: View {
    var viewModel: ViewModel

    @ViewBuilder
    private var content: some View {
        switch viewModel.state.data {
        case .loading: loadingView
        case .success(let data): moviesGrid(data.movies)
        case .failure(let error): errorView(error)
        }
    }
}
```
- State-driven rendering via switch statements
- Generic views accepting protocol-based ViewModels
- Automatic updates via @Observable

#### 4. **ViewModel** - State Management
```swift
@Observable
final class DefaultMovieListViewModel: MovieListViewModel {
    var state: MovieListViewModelState
    var onSideEffect: ((MovieListViewModelSideEffect) -> Void)?

    func onLoad() { /* Initialize state */ }
    func handleIntent(_ intent: MovieListViewModelIntent) { /* Process user actions */ }
}
```
- Three key methods: `onLoad()`, `handleIntent()`, side effect callbacks
- @MainActor for thread safety
- Observable pattern for reactive updates

## Project Structure

```
MovieApp/
├── MovieApp/                    # Main app target (entry point)
├── MovieApp-Showroom/          # Demo/preview app
├── MovieApp-Api/               # Container & DI configuration
├── MovieApp-Domain/            # Business logic layer
├── MovieApp-Data/              # Data access & repositories
└── MovieApp-Presentation/      # UI components & ViewModels
```

### Module Responsibilities

| Module | Purpose | Key Files |
|--------|---------|-----------|
| **Domain** | Business logic, interfaces | Repository protocols, UseCases, Domain models |
| **Data** | Data access, API integration | Repository implementations, Mappers, ApiModels |
| **Presentation** | UI & ViewModels | Views, ViewModels, Factories, Navigation |
| **Api** | Service configuration | Container (DI), FlowCoordinator, Common utils |

### Dependency Graph
```
Main App
  ├─→ Presentation
  │     └─→ Domain
  ├─→ Data
  │     └─→ Domain
  ├─→ Api
  │     └─→ Domain
  └─→ Domain (core business logic)
```

## Key Architectural Patterns

### 1. Protocol-Oriented Design

Every ViewModel follows a protocol-based contract:

```swift
protocol MovieListViewModel: ViewModel where
    Parameters == MovieListViewModelParameters,
    State == MovieListViewModelState,
    Intent == MovieListViewModelIntent,
    SideEffect == MovieListViewModelSideEffect { }
```

**Benefits:**
- Enforces MVI structure consistency
- Enables dependency injection
- Facilitates testing with mocks

### 2. Factory Pattern

Views are created via factories:

```swift
protocol MovieListViewFactory: ViewFactory where
    Parameters == MovieListViewModelParameters,
    View == MovieListView<DefaultMovieListViewModel> {}

final class DefaultMovieListViewFactory: MovieListViewFactory {
    func make(parameters: MovieListViewModelParameters)
        -> MovieListView<DefaultMovieListViewModel> {
        let viewModel = DefaultMovieListViewModel(parameters: parameters)
        return MovieListView(viewModel: viewModel)
    }
}
```

**Location:** `MovieApp-Presentation/Scenes/{Feature}/Factory/`

### 3. Generic Navigation System

**Router** (Type-safe navigation):
```swift
@Observable
class Router<Destination: Hashable & Identifiable> {
    var path = NavigationPath()
    var presentedSheet: Destination?
    var presentedFullScreen: Destination?

    func navigate(to destination: Destination)
    func presentSheet(_ destination: Destination)
    func presentFullScreen(_ destination: Destination)
    func pop()
    func popToRoot()
}
```

**Location:** `MovieApp-Presentation/Navigation/Router.swift`

**DestinationResolver** (Maps destinations to views):
```swift
protocol DestinationResolver {
    associatedtype Destination: Hashable & Identifiable
    @ViewBuilder
    func view(for destination: Destination) -> DestinationView
}

struct AppDestinationResolver: DestinationResolver {
    func view(for destination: AppDestination) -> some View {
        switch destination {
        case .movieDetails: DetailsView()
        }
    }
}
```

**Location:** `MovieApp-Presentation/Navigation/Resolver/AppDestinationResolver.swift`

**Usage in Views:**
```swift
NavigationContainer { MovieListView(...) }
// Or use convenience extension:
MovieListView(...).withNavigation()
```

### 4. Dependency Injection (FactoryKit)

**Container Setup:**
```swift
extension Container {
    var router: Factory<Router<AppDestination>> {
        self { Router<AppDestination>() }.singleton
    }
}
```

**Usage:**
```swift
@InjectedObservable(\.router) private var router
```

**Location:** `MovieApp-Api/Container/Container.swift`

## Current Features

### Movie List Feature (FirstView)

**Location:** `MovieApp-Presentation/Scenes/FirstView/`

**Components:**
- `MovieListView.swift` - Main UI with grid and carousel
- `MovieListViewModel.swift` - State management and intent handling
- `MovieListViewFactory.swift` - View composition

**Features:**
- 3-column grid display of movies
- "Most Watched" horizontal carousel
- Pull-to-refresh support
- Loading/success/error states
- AsyncImage integration with TMDB URLs
- 16 sample movies with metadata

**UI Components:**
```swift
// Grid item (3 columns)
struct MovieItemView: View {
    let url: URL
    let title: String
    // 112x162 image dimensions
    // Spring animation on tap
}

// Carousel item (horizontal scroll)
struct FeaturedMovieView: View {
    let url: URL
    let title: String
    // 180x260 image dimensions
}
```

**Sample Data:**
Movies include classics like "The Shawshank Redemption", "The Godfather", "The Dark Knight", etc., with TMDB poster URLs.

## File Locations Reference

### Presentation Layer
```
MovieApp-Presentation/
├── Core/
│   ├── ViewModel.swift              # Base ViewModel protocol
│   ├── ViewFactory.swift            # Base Factory protocol
│   └── ViewModelState.swift         # Generic state wrapper
├── Navigation/
│   ├── Router.swift                 # Generic router
│   ├── NavigationContainer.swift    # Navigation wrapper
│   ├── DestinationResolver.swift    # Resolver protocol
│   └── Resolver/
│       ├── AppDestination.swift     # App-specific destinations
│       └── AppDestinationResolver.swift
├── Scenes/
│   ├── FirstView/                   # Movie List feature
│   │   ├── View/
│   │   │   ├── MovieListView.swift
│   │   │   ├── MovieItemView.swift
│   │   │   └── FeaturedMovieView.swift
│   │   ├── ViewModel/
│   │   │   └── MovieListViewModel.swift
│   │   └── Factory/
│   │       └── MovieListViewFactory.swift
│   └── DetailsView/
│       └── DetailsView.swift        # Placeholder
└── Extension/
    └── ViewExtension.swift          # .withNavigation() helper
```

### Domain Layer
```
MovieApp-Domain/
├── Models/                          # Business domain models
│   └── MovieItem.swift
├── Repository/                      # Repository interfaces (protocols)
└── UseCase/                         # Business logic operations
```

### Data Layer
```
MovieApp-Data/
├── Repository/                      # Repository implementations
├── ApiModel/                        # API response models
├── Mapper/                          # ApiModel → DomainModel mapping
└── Gateway/                         # API request definitions
```

### Api Layer
```
MovieApp-Api/
├── Container/
│   └── Container.swift              # DI configuration
├── FlowCoordinator/                 # App flow management
└── Common/                          # Shared utilities
```

## Coding Conventions

### ViewModel Lifecycle
1. **onLoad()** - Called when view appears (via `.task`)
2. **handleIntent()** - Processes user actions
3. **onSideEffect** - Callback for navigation/external actions

### State Updates
```swift
// Always update state on MainActor
Task { @MainActor in
    state.data = .loading
    let result = await fetchData()
    state.data = .success(result)
}
```

### Naming Conventions
- **Protocols:** `{Feature}ViewModel`, `{Feature}ViewFactory`
- **Implementations:** `Default{Feature}ViewModel`, `Default{Feature}ViewFactory`
- **States:** `{Feature}ViewModelState`
- **Intents:** `{Feature}ViewModelIntent`
- **Side Effects:** `{Feature}ViewModelSideEffect`

### File Organization
```
Scenes/{FeatureName}/
├── View/
│   └── {Feature}View.swift
├── ViewModel/
│   └── {Feature}ViewModel.swift
└── Factory/
    └── {Feature}ViewFactory.swift
```

## Development Status

### Completed
- MVI architecture scaffolding
- Navigation system (Router, DestinationResolver)
- Movie List feature with UI
- Protocol-based ViewModel pattern
- Factory pattern setup
- Dependency injection infrastructure

### In Progress (Empty/Placeholder)
- Repository implementations (Domain/Data layers)
- UseCase implementations
- ApiModel structures
- Mapper implementations (Data → Domain)
- Container configuration
- FlowCoordinator setup
- DetailsView implementation
- Actual API integration

### Git History
Recent commits show active development:
```
83d5b18 Unfinished Navigation
e953ede Small refactor
c51bbe0 add empty files
446224a data files
```

## Development Guidelines

### Adding a New Feature

1. **Create Domain Models** (`Domain/Models/`)
   ```swift
   struct MyFeatureModel { ... }
   ```

2. **Define ViewModel Contract** (`Presentation/Scenes/MyFeature/ViewModel/`)
   ```swift
   enum MyFeatureViewModelIntent { ... }
   struct MyFeatureViewModelState { ... }
   enum MyFeatureViewModelSideEffect { ... }

   protocol MyFeatureViewModel: ViewModel where ... {}
   ```

3. **Implement ViewModel** (same file)
   ```swift
   @Observable
   final class DefaultMyFeatureViewModel: MyFeatureViewModel {
       func onLoad() { ... }
       func handleIntent(_ intent: MyFeatureViewModelIntent) { ... }
   }
   ```

4. **Create View** (`Presentation/Scenes/MyFeature/View/`)
   ```swift
   struct MyFeatureView<ViewModel: MyFeatureViewModel>: View {
       var viewModel: ViewModel
       var body: some View { ... }
   }
   ```

5. **Create Factory** (`Presentation/Scenes/MyFeature/Factory/`)
   ```swift
   protocol MyFeatureViewFactory: ViewFactory { ... }
   final class DefaultMyFeatureViewFactory: MyFeatureViewFactory { ... }
   ```

6. **Add Navigation Destination** (if needed)
   ```swift
   // In AppDestination.swift
   enum AppDestination: Hashable, Identifiable {
       case myFeature(parameters: ...)
   }

   // In AppDestinationResolver.swift
   func view(for destination: AppDestination) -> some View {
       switch destination {
       case .myFeature(let params):
           DefaultMyFeatureViewFactory().make(parameters: params)
       }
   }
   ```

### Navigation Patterns

**Push Navigation:**
```swift
@InjectedObservable(\.router) private var router
router.navigate(to: .myFeature)
```

**Sheet Presentation:**
```swift
router.presentSheet(.myFeature)
```

**Full Screen Cover:**
```swift
router.presentFullScreen(.myFeature)
```

**Back Navigation:**
```swift
router.pop()              // Go back one screen
router.popToRoot()        // Return to root
```

### Side Effects Pattern

```swift
// In ViewModel
func handleIntent(_ intent: Intent) {
    switch intent {
    case .didSelectItem:
        onSideEffect?(.navigateToDetails)
    }
}

// In View or parent coordinator
viewModel.onSideEffect = { [weak self] effect in
    switch effect {
    case .navigateToDetails:
        self?.router.navigate(to: .details)
    }
}
```

## Testing Strategy

### Protocol-Based Testing
Views and ViewModels use protocols, enabling easy mock injection:

```swift
// Create mock ViewModel for testing
class MockMovieListViewModel: MovieListViewModel {
    var state = MovieListViewModelState(data: .loading)
    func onLoad() { /* Mock implementation */ }
    func handleIntent(_ intent: MovieListViewModelIntent) { /* Track calls */ }
}

// Test view with mock
let mockVM = MockMovieListViewModel()
let view = MovieListView(viewModel: mockVM)
```

### Testing ViewModels
```swift
let viewModel = DefaultMovieListViewModel(parameters: .init())
viewModel.handleIntent(.removeAll)
XCTAssertEqual(viewModel.state.data, .success(.init(movies: [])))
```

## Technical Stack

**Frameworks:**
- **SwiftUI** - UI framework
- **Observation** - Reactive state (@Observable macro)
- **FactoryKit** - Dependency injection

**Modern Swift Features:**
- @Observable macro (iOS 17+)
- Async/await with @MainActor
- Generic protocols with associated types
- NavigationStack (SwiftUI 4+)

**Architecture Principles:**
- Clean Architecture (Domain → Data → Presentation)
- Dependency Inversion (protocols over concrete types)
- Single Responsibility
- Unidirectional data flow

## Common Tasks

### Adding a Repository
1. Define protocol in `Domain/Repository/`
2. Implement in `Data/Repository/`
3. Register in `Container.swift`
4. Inject via `@Injected(\.myRepository)`

### Updating State
```swift
// Always wrap in Task with @MainActor
Task { @MainActor in
    state.data = .loading
    do {
        let result = try await repository.fetch()
        state.data = .success(result)
    } catch {
        state.data = .failure(error)
    }
}
```

### Handling Loading States in View
```swift
@ViewBuilder
private var content: some View {
    switch viewModel.state.data {
    case .loading:
        ProgressView()
    case .success(let data):
        successView(data)
    case .failure(let error):
        ErrorView(error: error)
    }
}
```

## Contributors
- Tornike Bardadze (Primary developer)
- Giorgi Obgaidze (Contributor - DetailsView)

## Notes for Claude

- This project follows strict MVI patterns - always maintain the Intent → State → View flow
- Use protocol-based design for all ViewModels and Factories
- Navigation should go through the Router, never direct NavigationLink
- State updates MUST be on @MainActor
- File organization is strict - follow the Scenes/{Feature}/{Layer}/ structure
- Many files are placeholders - check for empty implementations before assuming functionality exists
- The main app entry point (MovieAppApp.swift) currently shows "Hello, world!" - navigation to MovieListView needs integration
- Sample data uses TMDB image URLs (https://image.tmdb.org/t/p/w500/...)
