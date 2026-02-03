import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'order_complete.dart';
import 'model/basket_manager.dart';
import 'input_card_details.dart';

class CompleteDetailsBottomSheet extends StatelessWidget {
  const CompleteDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none, // Allows the button to exist outside the box
      children: [
        // 1. The Main Content Box
        Container(
          // Increase this top margin to push the box further down from the button
          margin: EdgeInsets.only(top: 80.h),
          padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 20.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery address",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF27214D),
                ),
              ),
              SizedBox(height: 16.h),
              _buildTextField("10th avenue, Lekki, Lagos State"),
              SizedBox(height: 24.h),
              Text(
                "Number we can call",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF27214D),
                ),
              ),
              SizedBox(height: 16.h),
              _buildTextField("09090605708"),
              SizedBox(height: 40.h),
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Access the singleton instance and clear it
                          BasketManager().clearBasket();

                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const OrderComplete()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xffFFA451)),
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Pay on delivery',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xffFFA451),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),

                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent, // Required for the floating button
                            builder: (context) => const InputCardDetails(),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xffFFA451)),
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Pay with card',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xffFFA451),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 2. The Independent Floating Close Button
        Positioned(
          top: 20.h, // Adjusted to sit higher up, away from the white container
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 48.r,
              width: 48.r,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.black, size: 24.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }
}
