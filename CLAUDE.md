# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Running the Application
- `flutter run` - Run in development mode (uses local JSON data)
- `flutter run --target lib/main_development.dart` - Explicit development mode with local data
- `flutter run --target lib/main_staging.dart` - Staging mode with remote server data

### Code Generation
- `flutter packages pub run build_runner build` - Generate Freezed/JSON serialization code
- `flutter packages pub run build_runner watch` - Watch mode for automatic code generation

### Testing
- `flutter test` - Run unit and widget tests
- `flutter test integration_test/` - Run integration tests
- `flutter test test/specific_test_file.dart` - Run a specific test file

### Code Quality
- `flutter analyze` - Run static analysis with linting (includes `prefer_relative_imports` rule)

## Architecture Overview

This Flutter app follows **Clean Architecture** with strict separation of concerns:

### Layer Structure
- **Domain** (`lib/domain/`): Business entities (Freezed models) and use cases
- **Data** (`lib/data/`): Repository implementations (local/remote) and API services  
- **UI** (`lib/ui/`): MVVM pattern with ViewModels and Widgets organized by feature

### Key Patterns
- **Repository Pattern**: Each entity has an abstract repository with local/remote implementations
- **MVVM**: StateNotifiers handle business logic, Widgets handle presentation only
- **Riverpod**: Used for dependency injection and state management
- **Environment Configuration**: Development (local data) vs Staging (remote data)

### File Naming Conventions
- Repositories: `[entity]_repository.dart` (interface), `[entity]_repository_local.dart`, `[entity]_repository_remote.dart`
- Models: Domain models in `domain/models/`, API models in `data/services/api/model/`
- Tests: Mirror the lib structure in test directory

## Testing Strategy

### Test Organization
- **Unit Tests**: Repository and use case logic in `test/`
- **Widget Tests**: Screen components with mocked dependencies in `test/ui/`
- **Integration Tests**: End-to-end flows in `integration_test/`

### Testing Tools
- Use **Mocktail** for mocking external dependencies
- Use fake repositories from `testing/fakes/` for consistent test data
- Test app configuration available in `testing/app.dart`

## Code Generation Requirements

Run `flutter packages pub run build_runner build` after:
- Adding/modifying Freezed models
- Changing JSON serialization annotations
- Adding new API models

## Directory Structure & Coding Standards

### File Naming Conventions
All files use **snake_case** with descriptive suffixes:
- StateNotifiers: `*_notifier.dart` (e.g., `home_notifier.dart`)
- Repositories: `*_repository.dart` (interface), `*_repository_local.dart`, `*_repository_remote.dart`
- API Models: `*_api_model.dart` (e.g., `user_api_model.dart`)
- Screens: `*_screen.dart` (e.g., `home_screen.dart`)
- Use Cases: `*_use_case.dart` (e.g., `booking_create_use_case.dart`)

### Directory Organization
```
lib/
├── domain/models/[entity]/           # Business entities
│   ├── [entity].dart                 # Main model (Freezed)
│   ├── [entity].freezed.dart         # Generated file
│   ├── [entity].g.dart              # JSON serialization
│   └── [entity]_summary.dart        # Summary models
├── data/repositories/[entity]/       # Data access layer
│   ├── [entity]_repository.dart      # Abstract interface
│   ├── [entity]_repository_local.dart    # Local implementation
│   └── [entity]_repository_remote.dart   # Remote implementation
└── ui/[feature]/                     # Feature-based UI organization
    ├── notifiers/
    │   └── [feature]_notifier.dart   # StateNotifier/AsyncNotifier
    └── widgets/
        ├── [feature]_screen.dart     # Main screen
        └── [feature]_*.dart          # Components
```

### Freezed Model Standards
```dart
@freezed
class ModelName with _$ModelName {
  const factory ModelName({
    /// Required: Document each field with triple-slash comments
    /// Optional ID field - may be null if not yet stored
    int? id,
    
    /// Required field with clear description
    required String name,
    
    /// List fields with specific types
    required List<Activity> activities,
  }) = _ModelName;

  factory ModelName.fromJson(Map<String, Object?> json) => _$ModelNameFromJson(json);
}
```

### StateNotifier Implementation Pattern
```dart
@riverpod
class FeatureNotifier extends _$FeatureNotifier {
  final _log = Logger('FeatureNotifier');

  @override
  FutureOr<List<Model>> build() async {
    // Initial state loading
    return _loadData();
  }

  Future<List<Model>> _loadData() async {
    try {
      final repository = ref.read(repositoryProvider);
      final result = await repository.getData();
      switch (result) {
        case Ok<List<Model>>():
          _log.fine('Loaded successfully');
          return result.value;
        case Error<List<Model>>():
          _log.warning('Failed to load', result.error);
          throw result.error;
      }
    } catch (error) {
      _log.severe('Load failed', error);
      rethrow;
    }
  }

  Future<void> performAction(String parameter) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(repositoryProvider);
      final result = await repository.performAction(parameter);
      switch (result) {
        case Ok():
          state = AsyncData(await _loadData());
        case Error():
          state = AsyncError(result.error, StackTrace.current);
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}
```


### Repository Implementation Standards
```dart
/// Abstract repository interface - no implementation details
abstract class EntityRepository {
  Future<Result<List<Entity>>> getEntities();
  Future<Result<Entity>> getEntity(int id);
}

/// Local implementation with dependency injection
class EntityRepositoryLocal implements EntityRepository {
  EntityRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;

  @override
  Future<Result<List<Entity>>> getEntities() async {
    try {
      return Result.ok(await _localDataService.getEntities());
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
```

### Import Organization Rules
Imports must follow this strict order:
1. Dart core libraries (`dart:async`, `dart:convert`)
2. Flutter SDK (`package:flutter/material.dart`)
3. External packages (alphabetical order)
4. Relative imports (project files)
5. Part declarations (code generation)

**Always use relative imports** for project files:
```dart
// ✅ Correct
import '../../../data/repositories/booking/booking_repository.dart';

// ❌ Incorrect
import 'package:compass_app/data/repositories/booking/booking_repository.dart';
```

### Error Handling Standards
- Use **Result<T>** pattern with `Ok<T>` and `Error<T>` types
- Always use `switch` expressions for Result handling
- Include error logging with context
- Use `finally` blocks for cleanup (especially `notifyListeners()`)

### Command Pattern Usage
- **Command0**: For parameterless actions
- **Command1<T, A>**: For single-parameter actions  
- Commands provide automatic state management (running, error, completed)
- Initialize in constructor, use `..execute()` for immediate execution

### Testing Conventions
- Test file names: `*_test.dart`
- Use `group()` for organizing related tests
- Test names: `'should [action/behavior]'` format
- Use **Fake** implementations for simple mocking
- Use **Mock** objects (Mocktail) for complex verification
- Helper functions for widget setup: `loadWidget(WidgetTester tester)`
- Use `ProviderContainer` for testing providers and notifiers

### Logging Standards
```dart
class ClassName {
  final _log = Logger('ClassName'); // Use exact class name
  
  void method() {
    _log.fine('Success message');          // Success operations
    _log.warning('Warning', error);        // Errors with context
    _log.severe('Critical error', error);  // Critical failures
  }
}
```

## Data Model Reference

**IMPORTANT**: Always refer to `DATABASE_STRUCTURE.md` for comprehensive data model definitions and entity relationships before implementing any domain models or repositories. This document contains:

- Complete entity definitions (Word, Meaning, Media, Flashcard, Template, Comparison)
- Entity relationship mappings and foreign key constraints
- Data validation rules and constraints
- API endpoint specifications matching the frontend TypeScript definitions
- Migration strategy and implementation phases

When creating new models or modifying existing ones, ensure they align with the structure defined in `DATABASE_STRUCTURE.md`.

## Development Notes

- All models use **Freezed** for immutability and code generation
- API models have separate JSON serialization from domain models
- Local data stored in `assets/` directory (activities.json, destinations.json)
- Uses `go_router` for declarative navigation
- Material Design with custom theming in `ui/core/themes/`
- **Riverpod** provides type-safe dependency injection and state management
- **Result<T>** pattern eliminates exception-based error handling

### Audio Feedback

After completing any significant process or action (such as video recording, data saving, QR code scanning, etc.), ALWAYS provide audio feedback to the user by playing a notification sound. This improves user experience by providing clear confirmation that the action has been completed successfully.

**IMPORTANT**: Task completion sound is MANDATORY - you must implement audio feedback for every task completion without exception.