import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:korean_romanization_converter/korean_romanization_converter.dart';

void main() {}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final converter = KoreanRomanizationConverter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(converter.romanize('안녕하세요?')),
        ),
      ),
    );
  }
}
