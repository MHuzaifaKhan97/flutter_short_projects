import 'package:flutter/material.dart';
import 'package:flutter_unit_testing/provider/article_provider.dart';
import 'package:flutter_unit_testing/screens/articles_screen.dart';
import 'package:flutter_unit_testing/service/article_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(NewsService()),
        child: NewsPage(),
      ),
    );
  }
}
