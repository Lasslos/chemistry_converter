import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.deepOrange,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepOrange,
    ),
    themeMode: ThemeMode.system,
    home: const HomePage(),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: const Text('Chemistry Converter'),
    ),
    body: const Padding(
      padding: EdgeInsets.all(10),
      child: Placeholder(
        color: Colors.deepOrange,
      ),
    ),
  );
}
