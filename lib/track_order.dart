import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum StatusType { completed, inProgress, pending }

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Header Section
          Container(
            height: 170.h,
            padding: EdgeInsets.only(top: 60.h, left: 24.w),
            decoration: const BoxDecoration(color: Color(0xffFFA451)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 14.sp, color: Colors.black),
                        Text("Go back", style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Text("Delivery Status",
                    style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w500)),
              ],
            ),
          ),

          // 2. Timeline List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              children: [
                _buildTimelineItem(
                  title: "Order Taken",
                  assetPath: "assets/customer-order-orders-icon.png",
                  iconBgColor: const Color(0xFFFFFAEB),
                  statusType: StatusType.completed,
                ),
                _buildTimelineItem(
                  title: "Order Is Being Prepared",
                  assetPath: "assets/68-512-removebg-preview.png",
                  iconBgColor: const Color(0xFFF1EFF6),
                  statusType: StatusType.completed,
                ),
                _buildTimelineItem(
                  title: "Order Is Being Delivered",
                  subtitle: "Your delivery agent is coming",
                  assetPath: "assets/delivery-man-riding-red-scooter.png",
                  iconBgColor: const Color(0xFFFFF2E7),
                  statusType: StatusType.inProgress,
                  showMap: true, // This triggers the map and extra gap
                ),
                _buildTimelineItem(
                  title: "Order Received",
                  useIcon: true,
                  icon: Icons.check_circle,
                  iconBgColor: const Color(0xFFE0FFE5),
                  iconColor: const Color(0xFF4CD964),
                  statusType: StatusType.pending,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    String? subtitle,
    String? assetPath,
    IconData? icon,
    bool useIcon = false,
    required Color iconBgColor,
    Color? iconColor,
    required StatusType statusType,
    bool isLast = false,
    bool showMap = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT COLUMN: ICON AND DASHED LINE
          SizedBox(
            width: 64.r,
            child: Column(
              children: [
                Container(
                  height: 64.r,
                  width: 64.r,
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: useIcon
                      ? Icon(icon, color: iconColor, size: 32.sp)
                      : Image.asset(assetPath!, fit: BoxFit.contain),
                ),
                if (!isLast)
                  Expanded(
                    child: CustomPaint(
                      size: const Size(2, double.infinity),
                      painter: DashLinePainter(color: const Color(0xffFFA451)),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 32.w),

          // RIGHT COLUMN: TEXT, MAP, AND STATUS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),
                          Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF27214D))),
                          if (subtitle != null)
                            Text(subtitle, style: TextStyle(fontSize: 14.sp, color: Colors.black54)),
                        ],
                      ),
                    ),
                    // STATUS INDICATORS
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: _buildStatusIndicator(statusType),
                    ),
                  ],
                ),

                // MAP PREVIEW (If applicable)
                if (showMap) ...[
                  SizedBox(height: 20.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset(
                      "assets/Rectangle 45.png",
                      height: 160.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20.h), // Gap before the final item
                ] else if (!isLast)
                  SizedBox(height: 50.h), // Default gap between items
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(StatusType type) {
    if (type == StatusType.completed) {
      return const Icon(Icons.check_circle, color: Color(0xFF4CD964), size: 24);
    } else if (type == StatusType.inProgress) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Color(0xffFFA451), shape: BoxShape.circle),
        child: const Icon(Icons.phone, color: Colors.white, size: 18),
      );
    } else {
      return Row(
        children: List.generate(3, (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 6.r,
          height: 6.r,
          decoration: const BoxDecoration(color: Color(0xffFFD4AD), shape: BoxShape.circle),
        )),
      );
    }
  }
}

class DashLinePainter extends CustomPainter {
  final Color color;
  DashLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 2;
    double dashSpace = 10;
    double startY = 10; // Padding from top icon

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    while (startY < size.height - 10) { // Padding before bottom icon
      canvas.drawLine(
          Offset(size.width / 2, startY),
          Offset(size.width / 2, startY + dashHeight),
          paint
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}