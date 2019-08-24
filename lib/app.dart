import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/pages/home/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(title: 'Kyouen VS'),
    );
  }
}
