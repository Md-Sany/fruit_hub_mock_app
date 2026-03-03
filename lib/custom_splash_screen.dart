import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'welcome_screen.dart';
import 'package:get/get.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    // We start the loading process right away
    initializeAppAndNavigate();
  }

  void initializeAppAndNavigate() async {
    // 1. SIMULATE LOADING TIME (e.g., 2 seconds)
    // This allows the user to see the CustomSplashScreen with the text banner.
    await Future.delayed(const Duration(seconds: 5));

    // 2. CHECK if the widget is still in the tree.
    if (!mounted) return;

    // 3. REMOVE THE NATIVE SPLASH SCREEN.
    // This must happen AFTER your CustomSplashScreen is visible.
    // If you remove it too early, the CustomSplashScreen won't have time to render.
    FlutterNativeSplash.remove();

    // 4. NAVIGATE to the Main App Screen.
    Get.off(() => const WelcomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    // Ensure this widget displays the full image with the 'Fruit Hub' text
    // as it's the screen you want users to see after the native splash.
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/icon/icon.png',
              width: 250.w,
              height: 250.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}