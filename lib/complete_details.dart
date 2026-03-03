import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'order_complete.dart';
import 'model/basket_manager.dart';
import 'input_card_details.dart';
import 'package:get/get.dart';

class CompleteDetailsBottomSheet extends StatefulWidget {
  const CompleteDetailsBottomSheet({super.key});

  @override
  State<CompleteDetailsBottomSheet> createState() => _CompleteDetailsBottomSheetState();
}

class _CompleteDetailsBottomSheetState extends State<CompleteDetailsBottomSheet> {
  // Find the existing BasketController instance
  final BasketController basketController = Get.find<BasketController>();

  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _processPayment(bool isCard) {
    if (_formKey.currentState!.validate()) {
      if (isCard) {
        // Use GetX BottomSheet for consistency
        Get.bottomSheet(
          const InputCardDetails(),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        );
      } else {
        // Use the controller instance to clear the basket
        basketController.clearBasket();

        // Use GetX to clear the stack and move to the success screen
        Get.offAll(() => const OrderComplete());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // This ensures the sheet moves up when the keyboard appears
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                    _buildTextField(
                      controller: _addressController,
                      hint: "10th avenue, Lekki, Lagos State",
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Please enter an address";
                        return null;
                      },
                    ),
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
                    _buildTextField(
                      controller: _phoneController,
                      hint: "09090605708",
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Please enter a phone number";
                        if (value.length < 10) return "Enter a valid phone number";
                        return null;
                      },
                    ),
                    SizedBox(height: 40.h),
                    SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                              text: 'Pay on delivery',
                              onPressed: () => _processPayment(false),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: _buildActionButton(
                              text: 'Pay with card',
                              onPressed: () => _processPayment(true),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Floating Close Button
          Positioned(
            top: 20.h,
            child: GestureDetector(
              onTap: () => Get.back(), // GetX version of pop
              child: Container(
                height: 48.r,
                width: 48.r,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Icon(Icons.close, color: Colors.black, size: 24.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF3F3F3),
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.transparent, width: 1),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: const Color(0xffFFA451), width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        errorStyle: const TextStyle(height: 0.8),
      ),
    );
  }

  Widget _buildActionButton({required String text, required VoidCallback onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xffFFA451)),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: const Color(0xffFFA451), fontSize: 14.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}