<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

## Features

Korean romanization for dart flutter.

Thanks to 
1. https://github.com/AaronO/kpop

## Getting Started
Add korean_romanization_converter to your pubspec.yaml file:

```dart
dependencies:
  korean_romanization_converter:
```

## Usage

You can convert korean to romanization in simple way.

```dart
final converter = KoreanRomanizationConverter();

var result = converter.romanize('안녕하세요?');
```
