import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_screen_one.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  final TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                          child: Image.asset('assets/kisspng-fruit-basket.png'),
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
                    SizedBox(height: 40.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What is your firstname?',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF333333),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            controller: _nameController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Tony',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16.sp,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: EdgeInsets.all(16.r),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: const BorderSide(color: Color(0xffFFA451)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: const BorderSide(color: Colors.red, width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: const BorderSide(color: Colors.red, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              bottom: true,
              child: Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h, top: 10.h),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String name = _nameController.text.trim();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeScreenOne(userName: name),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    backgroundColor: const Color(0xffFFA451),
                    minimumSize: Size(double.infinity, 56.h),
                  ),
                  child: Text(
                    "Start Ordering",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}