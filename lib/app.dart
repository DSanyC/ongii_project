import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home_page.dart';

class OngiiApp extends StatelessWidget {
  const OngiiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ongii',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
