import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepOrange,
        ),
        home: HomePage(),
      );
}
