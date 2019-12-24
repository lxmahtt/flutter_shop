import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/index_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活',
      theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
}