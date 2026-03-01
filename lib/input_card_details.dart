import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/basket_manager.dart';
import 'order_complete.dart';

class InputCardDetails extends StatefulWidget {
  const InputCardDetails({super.key});

  @override
  State<InputCardDetails> createState() => _InputCardDetailsState();
}

class _InputCardDetailsState extends State<InputCardDetails> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _ccvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _dateController.dispose();
    _ccvController.dispose();
    super.dispose();
  }

  void _completeOrder() {
    if (_formKey.currentState!.validate()) {
      BasketManager().clearBasket();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const OrderComplete()),
            (route) => false,
      );
    }
  }

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Card Holders Name"),
                        SizedBox(height: 12.h),
                        _buildTextField(
                          controller: _nameController,
                          hint: "Adolphus Chris",
                          validator: (val) => (val == null || val.isEmpty) ? "Enter holder name" : null,
                        ),
                        SizedBox(height: 24.h),

                        _buildLabel("Card Number"),
                        SizedBox(height: 12.h),
                        _buildTextField(
                          controller: _cardNumberController,
                          hint: "1234 5678 9012 1314",
                          keyboardType: TextInputType.number,
                          formatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                            CardNumberFormatter(),
                          ],
                          validator: (val) {
                            if (val == null || val.isEmpty) return "Enter card number";
                            if (val.replaceAll(' ', '').length < 16) return "Invalid card number";
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("Date"),
                                  SizedBox(height: 12.h),
                                  _buildTextField(
                                    controller: _dateController,
                                    hint: "10/30",
                                    keyboardType: TextInputType.number,
                                    formatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4),
                                      CardDateFormatter(),
                                    ],
                                    validator: (val) {
                                      if (val == null || val.isEmpty) return "Enter date";
                                      if (val.length < 5) return "Invalid format";

                                      int month = int.parse(val.substring(0, 2));
                                      if (month < 1 || month > 12) return "Invalid month";

                                      return null;
                                    },
                                  ),
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
                                  _buildTextField(
                                    controller: _ccvController,
                                    hint: "123",
                                    keyboardType: TextInputType.number,
                                    formatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                    validator: (val) {
                                      if (val == null || val.length < 3) return "Invalid";
                                      return null;
                                    },
                                  ),
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
                                onPressed: _completeOrder,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? formatters,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16.sp),
        filled: true,
        fillColor: const Color(0xFFF3F3F3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        errorStyle: const TextStyle(height: 0.8),
      ),
    );
  }
}

class CardDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (oldValue.text.length > text.length) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;

      if (nonZeroIndex == 2 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    final String string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) return newValue;

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var index = i + 1;
      if (index % 4 == 0 && index != text.length) {
        buffer.write(' ');
      }
    }

    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}