import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import added
import 'home_screen_one.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 470.h, // Replaced MediaQuery
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xffFFA451)),
                ),
                Positioned(
                  height: 260.h,
                  width: 301.w,
                  top: 155.h,
                  left: 55.w,
                  child: Image.asset('assets/kisspng-fruit-basket.png'),
                ),
                Positioned(
                  height: 38.h,
                  width: 50.w,
                  top: 135.h,
                  right: 40.w, // Adjusted for better alignment
                  child: Image.asset('assets/fruit-drops2-removebg-preview 1.png'),
                ),
                // Shadow ellipses
                Positioned(
                  height: 12.h,
                  width: 300.w,
                  top: 425.h,
                  left: 56.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF08626),
                      borderRadius: BorderRadius.all(Radius.elliptical(300.w, 12.h)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What is your firstname?',
                    style: TextStyle(
                      fontSize: 20.sp, // Responsive font
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Tony',
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.all(16.r), // Responsive padding
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(color: Color(0xffFFA451)),
                      ),
                    ),
                  ),
                  SizedBox(height: 93.h),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomeScreenOne()),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      backgroundColor: const Color(0xffFFA451),
                      minimumSize: Size(double.infinity, 56.h),
                    ),
                    child: Text("Start Ordering", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}