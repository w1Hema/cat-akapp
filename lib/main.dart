import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';

import 'utils/globals.dart';

void main() {
  runApp(const CyberCVApp());
}

class CyberCVApp extends StatefulWidget {
  const CyberCVApp({super.key});

  @override
  State<CyberCVApp> createState() => _CyberCVAppState();
}

class _CyberCVAppState extends State<CyberCVApp> with SingleTickerProviderStateMixin {
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _colorAnimation = TweenSequence<Color?>(
      [
        TweenSequenceItem(weight: 1.0, tween: ColorTween(begin: const Color(0xFFFF6600), end: const Color(0xFFFF0055))), // Orange -> Pink
        TweenSequenceItem(weight: 1.0, tween: ColorTween(begin: const Color(0xFFFF0055), end: const Color(0xFF7C3AED))), // Pink -> Purple
        TweenSequenceItem(weight: 1.0, tween: ColorTween(begin: const Color(0xFF7C3AED), end: const Color(0xFF00C6FF))), // Purple -> Blue
        TweenSequenceItem(weight: 1.0, tween: ColorTween(begin: const Color(0xFF00C6FF), end: const Color(0xFF00E676))), // Blue -> Green
        TweenSequenceItem(weight: 1.0, tween: ColorTween(begin: const Color(0xFF00E676), end: const Color(0xFFFFD700))), // Green -> Yellow
        TweenSequenceItem(weight: 1.0, tween: ColorTween(begin: const Color(0xFFFFD700), end: const Color(0xFFFF6600))), // Yellow -> Orange
      ],
    ).animate(_colorController);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            final dynamicColor = _colorAnimation.value ?? const Color(0xFFFF6600);

            return MaterialApp(
              title: 'ENG/IBRAHIM FATHY',
              debugShowCheckedModeBanner: false,
              themeMode: currentMode,
              theme: ThemeData(
                brightness: Brightness.light,
                scaffoldBackgroundColor: const Color(0xFFF3F4F6),
                primaryColor: dynamicColor,
                colorScheme: ColorScheme.light(
                  primary: dynamicColor,
                  secondary: const Color(0xFF00C6FF),
                  surface: Colors.white,
                ),
                textTheme: GoogleFonts.cairoTextTheme(ThemeData.light().textTheme),
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: const Color(0xFF040508),
                primaryColor: dynamicColor,
                colorScheme: ColorScheme.dark(
                  primary: dynamicColor,
                  secondary: const Color(0xFF00C6FF),
                  surface: const Color(0xFF0A0C14),
                ),
                textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
                useMaterial3: true,
              ),
              builder: (context, child) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: child!,
                );
              },
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
