import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (_, __, ___) => const AuthScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    blurRadius: 50,
                    spreadRadius: 10,
                  )
                ],
              ),
              child: const Icon(
                Icons.fingerprint,
                size: 80,
                color: Colors.white,
              ).animate(onPlay: (controller) => controller.repeat())
               .shimmer(duration: 2.seconds, color: Theme.of(context).primaryColor),
            ).animate().scale(duration: 1.seconds, curve: Curves.easeOutBack),
            
            const SizedBox(height: 30),
            
            Text(
              "ENG / IBRAHIM FATHY",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
                color: Theme.of(context).primaryColor,
              ),
            ).animate().fade(delay: 500.ms).slideY(begin: 0.5, end: 0),
            
            const SizedBox(height: 10),
            
            Text(
              "مرحباً بك في عالمي الرقمي",
              style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7)),
            ).animate().fade(delay: 1000.ms),
          ],
        ),
      ),
    );
  }
}
