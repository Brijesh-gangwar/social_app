import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/feed_controller.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const InstagramCloneApp());
}

class InstagramCloneApp extends StatelessWidget {
  const InstagramCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.light();

    return ChangeNotifierProvider(
      create: (_) => FeedController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Feed',
        theme: baseTheme.copyWith(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0.5,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
