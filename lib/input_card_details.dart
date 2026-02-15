import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/basket_manager.dart';
import 'order_complete.dart';

class InputCardDetails extends StatelessWidget {
  const InputCardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(top: 80.h),
                padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 30.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Card Holders Name"),
                      SizedBox(height: 12.h),
                      _buildTextField("Adolphus Chris"),
                      SizedBox(height: 24.h),

                      _buildLabel("Card Number"),
                      SizedBox(height: 12.h),
                      _buildTextField("1234 5678 9012 1314"),
                      SizedBox(height: 24.h),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Date"),
                                SizedBox(height: 12.h),
                                _buildTextField("10/30"),
                              ],
                            ),
                          ),
                          SizedBox(width: 25.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("CCV"),
                                SizedBox(height: 12.h),
                                _buildTextField("123"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),

                      SafeArea(
                        top: false,
                        child: Container(
                          width: double.infinity,
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB067),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                BasketManager().clearBasket();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => const OrderComplete()),
                                      (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                "Complete Order",
                                style: TextStyle(
                                  color: const Color(0xFFFFB067),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 20.h,
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
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF27214D),
      ),
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
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        ),
      ),
    );
  }
}