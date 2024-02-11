# frogger

The blog that croaks about current events

![logo](./images/logo.png)

## Localizations

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