# frogger

The blog that croaks

![logo](./images/logo.png)

## Architecture

### Frontend

The code in the *lib* directory is split into five subdirectories:
- l10n: custom localization data arb-files in german and english
- models: data models with business logic
- routes: the screens used in the app
- services: interfaces to data providers, contains only pocketbase interface at the moment
- widgets: custom widgets that are used in other widgets or routes

Test code is separated into the *test* and *integration_test* directories.

Resources are saved directly in the directory *images*

#### State management

The state of the blogs is tracked in the *models/blog*. It contains all logic to manipulate blogs and informs the api of changes.

The state of the api connection and login status is tracked in the *services/blogapi*. This is a holdover from the pocketbase dart api. A refactoring is needed to split the login info and functions.

### Backend

A pocketbase instance is used as backend with tree collections.

- users: username and login info
- blogs: blogpost with title, content and author
- likes: which user has liked what blogpost, separate for timestamp info and easier selection

## Testing

Unit and widget tests are located in the *test* directory. They are tested in the background without a gui.

Start them in the terminal with 

```
flutter test
```

Integration tests are located in the *integration_test* directory. They will use the currently setup device for testing.

Start them in the terminal with

```
flutter test integration_test
```

### Build robust tests

Tips to build robust tests:
- Use tap() instead of tapAt() because a widget position can change
- Widgets depend on info provided by the Scaffold, when testing them separatly you have to provide this information by yourself (like the text direction)
- modularize and reuse common actions used in end to end tests
- hard to locate widgets can be found indirectly with find.ancestor() and find.descendant()
- for detailed widget inspection not possible by an expect()-check use the tester.widget() method

### Setup

You need the following packages:

- flutter_test: widget testing
- integration_test: widget testing
- flutter_driver: testing on a device
- convenient_test: optional for better test overview gui

## Localizations

After a change in *lib/l10n* rebuild the localization by running

```
flutter pub get
```

### Setup

[From the official documentaion](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)

add localization package

```
flutter pub add flutter_localizations --sdk=flutter
flutter pub add intl:any
```

add localization delegates and supported locales to the MaterialApp

```
import 'package:flutter_localizations/flutter_localizations.dart';
```

```
localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
],
supportedLocales: [
    Locale('en'),
    Locale('de'),
],
```

### Own localizations

Set generate to true in the pubspec.yaml

Create the l10n.yaml file in the root and set the default content

```
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

Create the app resource bundles for the translations in /lib/l10n/.
Name them app_{localizationcode}.arp (e.g. app_en.arp for english).

After creation of the /lib/l10n/app_en.arp file set the app localization delegate.

```
flutter pub add intl:any
```

```
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```

```
localizationsDelegates: [
    AppLocalizations.delegate, // Add this line
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
```

or you can shorten the localization intit with the auto-generated lists

```
localizationsDelegates: AppLocalizations.localizationsDelegates,
supportedLocales: AppLocalizations.supportedLocales,
```

Now you can use the localization texts anywhere with the AppLocalizations class

```
title: Text(AppLocalizations.of(context)!.helloWorld)
```