import 'package:flutter/material.dart';
import 'package:zaka/home_page.dart';

void main() {
  runApp(
    SadakaCalc(),
  );
}

class SadakaCalc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kokotoa Mgawanyo',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: MainHomePage(title: 'Kokotoa Mgawanyo'),
    );
  }
}
