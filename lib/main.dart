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
    final textTheme = GoogleFonts.robotoTextTheme(baseTheme.textTheme).copyWith(
      bodyMedium: GoogleFonts.roboto(fontSize: 14, height: 1.3),
      bodySmall: GoogleFonts.roboto(fontSize: 12, height: 1.3),
      titleMedium: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 15),
    );

    return ChangeNotifierProvider(
      create: (_) => FeedController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Feed',
        theme: baseTheme.copyWith(
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.white,
          textTheme: textTheme,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0.5,
          ),
          snackBarTheme: const SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
