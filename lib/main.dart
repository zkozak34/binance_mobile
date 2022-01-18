import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';

void main() => {runApp(const MyApp())};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Binance Mobile',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
