import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'authentication_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 470.h,
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xffFFA451)),
              ),
              Positioned(
                height: 260.h,
                width: 301.w,
                top: 155.h,
                left: 55.w,
                child: Image.asset('assets/imgbin-basket-of-fruit.png'),
              ),
              Positioned(
                height: 38.h,
                width: 50.w,
                top: 135.h,
                right: 40.w,
                child: Image.asset('assets/fruit-drops2-removebg-preview 1.png'),
              ),
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
          // Using Expanded + Spacer to pin the button to the bottom
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  Text(
                    'Get The Freshest Fruit Salad Combo',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'We deliver the best and freshest fruit salad in town. Order for a combo today!!!',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF666666),
                    ),
                  ),
                  const Spacer(), // Pushes the button to the bottom
                  SafeArea(
                    top: false,
                    bottom: true,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const AuthenticationScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          backgroundColor: const Color(0xffFFA451),
                          minimumSize: Size(double.infinity, 56.h),
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h), // Fixed distance from bottom
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}