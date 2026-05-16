# evencir_app
The Evencir App is a Fitness App prototype. It is made to showcase flutter skills.
## Dependencies Used & Why

### Flutter SDK
- `flutter`: Core framework used to build the mobile app UI, navigation, layout, and platform integration.

### Main Packages
- `flutter_svg`: Used to render SVG icons and illustrations from the `assets/icons/` folder.
- `flutter_screenutil`: Used to make the UI responsive across different screen sizes.
- `table_calendar`: Used for the calendar views in the Plan and Nutrition screens.
- `bloc`: Used for business logic and shared app state management.
- `flutter_bloc`: Used to connect blocs to the Flutter UI with `BlocProvider` and `BlocBuilder`.
- `syncfusion_flutter_charts`: Used for chart-based visualizations and insight widgets.
- `cupertino_icons`: Provides iOS-style system icons for the app.

### Dev Dependencies
- `build_runner`: Used to generate code, including asset references.
- `flutter_gen_runner`: Used to generate strongly typed asset accessors in `lib/gen/`.
- `flutter_test`: Used for widget and unit testing.
- `flutter_lints`: Provides recommended Dart and Flutter lint rules.

## Project Structure

The app follows a clean, feature-oriented structure inside `lib/`.

```text
lib/
├── core/
├── data/
├── domain/
├── gen/
├── presentation/
└── main.dart
```

### `lib/core/`
Shared app-wide utilities and helpers.
- `utils/`: Color tokens, text styles, and shared formatters.
- `network/`: Network-related helpers and setup.
- `error/`: Error handling and failure definitions.
- `usecases/`: Shared base use case abstractions.

### `lib/data/`
Data layer implementation details.
- `datasources/`: Local or remote sources of raw data.
- `models/`: Data models used by the app.
- `repositories/`: Concrete repository implementations.

### `lib/domain/`
Business logic contracts and use cases.
- `repositories/`: Repository interfaces.
- `usecases/`: Reusable application actions that orchestrate data access.
- `entities/`: Domain entities, when needed.

### `lib/presentation/`
UI layer of the app.
- `pages/`: Full screens such as Plan, Nutrition, Mood, and Home.
- `widgets/`: Reusable UI components used across screens.
- `bloc/`: Shared bloc state and events for screen interaction.
- `blocs/`: Additional bloc-related structures if needed by the app.

### `lib/gen/`
Generated code.
- Contains generated asset bindings and other code created by build tools.

### `lib/main.dart`
App entry point that bootstraps the Flutter app.

## App Screenshots

Screenshots of the app are available in the `appscreenshots/` folder.

### Mood
![Mood Screen 1](appscreenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-16%20at%2016.32.53.png)
![Mood Screen 2](appscreenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-16%20at%2016.32.59.png)
![Mood Screen 3](appscreenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-16%20at%2016.33.03.png)
![Mood Screen 4](appscreenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-16%20at%2016.33.07.png)

### Plan
![Plan Screen 1](appscreenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-16%20at%2017.02.37.png)
![Plan Screen 2](appscreenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-16%20at%2017.02.45.png)

### Nutrition
![Nutrition Screen 1](appscreenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-16%20at%2016.33.37.png)
![Nutrition Screen 2](appscreenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-16%20at%2016.33.39.png)

## App Video

- [Watch the app video](https://drive.google.com/file/d/1L0J1wCAG0FRLJKahuOBUewbTqp9tr0Kj/view?usp=sharing)

## App APK

- [Download the APK](apprelease/app-release.apk)
