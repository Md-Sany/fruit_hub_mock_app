import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum StatusType { completed, inProgress, pending }

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Section
          Container(
            height: 170.h,
            padding: EdgeInsets.only(top: 60.h, left: 24.w),
            decoration: const BoxDecoration(color: Color(0xffFFA451)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(), // GetX navigation
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 14.sp, color: Colors.black),
                        Text(
                            "Go back",
                            style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Text(
                  "Delivery Status",
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),

          // Order Status List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              children: [
                _buildStatusItem(
                  title: "Order Taken",
                  status: StatusType.completed,
                  showLine: true,
                ),
                _buildStatusItem(
                  title: "Order Is Being Prepared",
                  status: StatusType.completed,
                  showLine: true,
                ),
                _buildStatusItem(
                  title: "Order Is Being Delivered",
                  subtitle: "Your delivery man is coming",
                  status: StatusType.inProgress,
                  showLine: true,
                  trailing: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: const BoxDecoration(color: Color(0xffFFA451), shape: BoxShape.circle),
                    child: Icon(Icons.phone, color: Colors.white, size: 20.sp),
                  ),
                ),
                _buildStatusItem(
                  title: "Order Received",
                  status: StatusType.pending,
                  showLine: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem({
    required String title,
    String? subtitle,
    required StatusType status,
    required bool showLine,
    Widget? trailing,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              _buildStatusIcon(status),
              if (showLine)
                Expanded(
                  child: CustomPaint(
                    size: const Size(2, double.infinity),
                    painter: DashLinePainter(
                      color: status == StatusType.completed
                          ? const Color(0xffFFA451)
                          : const Color(0xffFFD4AD),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20.w),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF27214D),
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      subtitle,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                    ),
                  ),
                SizedBox(height: 50.h), // Spacing between items
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildStatusIcon(StatusType type) {
    switch (type) {
      case StatusType.completed:
        return Icon(Icons.check_circle, color: const Color(0xFF4CD964), size: 30.sp);
      case StatusType.inProgress:
        return Container(
          height: 30.r,
          width: 30.r,
          decoration: const BoxDecoration(color: Color(0xffFFA451), shape: BoxShape.circle),
          child: Icon(Icons.access_time_filled, color: Colors.white, size: 18.sp),
        );
      case StatusType.pending:
        return Container(
          height: 30.r,
          width: 30.r,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffFFD4AD), width: 2),
            shape: BoxShape.circle,
          ),
        );
    }
  }
}

class DashLinePainter extends CustomPainter {
  final Color color;
  DashLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}