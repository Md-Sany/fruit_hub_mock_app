import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'track_order.dart';
import 'home_screen_one.dart';
import 'package:get/get.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // If they try to use system back button, force them to Home and clear stack
        Get.offAll(() => HomeScreenOne());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 164.h,
                      width: 164.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0FFE5),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: const Color(0xFF4CD964),
                      size: 100.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                "Congratulations!!!",
                style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF27214D)
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Your order have been taken and is being attended to",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color(0xFF27214D)
                ),
              ),
              SizedBox(height: 60.h),

              // Navigation Buttons
              SizedBox(
                width: 150.w,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const TrackOrder()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFA451),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: Text(
                      "Track order",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.offAll(() => HomeScreenOne()),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xffFFA451)),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: Text(
                      "Continue shopping",
                      style: TextStyle(color: const Color(0xffFFA451), fontSize: 16.sp, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}