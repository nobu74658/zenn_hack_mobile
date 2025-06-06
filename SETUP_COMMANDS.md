# Setup Commands

After implementing the repository interfaces and local implementations, run the following commands to complete the setup:

## 1. Install Dependencies
```bash
flutter pub get
```

## 2. Generate Code
Run the build_runner to generate code for:
- Freezed models (.freezed.dart and .g.dart files)
- Riverpod providers (.g.dart files)

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## 3. Analyze Code Quality
```bash
flutter analyze
```

## 4. Run Tests (optional)
```bash
flutter test
```

## Notes
- The `--delete-conflicting-outputs` flag is used to handle any conflicts with existing generated files
- If you encounter any issues with code generation, you can try cleaning first:
  ```bash
  flutter packages pub run build_runner clean
  flutter packages pub run build_runner build --delete-conflicting-outputs
  ```
- All generated files (*.g.dart, *.freezed.dart) should be committed to the repository