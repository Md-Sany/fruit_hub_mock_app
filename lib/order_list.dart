import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'complete_details.dart';
import 'model/basket_manager.dart'; // Ensure this contains the GetX BasketController

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the existing BasketController
    final BasketController basketController = Get.find<BasketController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Section
          Container(
            height: 160.h,
            padding: EdgeInsets.only(top: 30.h, left: 24.w),
            decoration: const BoxDecoration(color: Color(0xffFFA451)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 14.sp, color: Colors.black),
                        Text(
                          "Go back",
                          style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
                Text(
                  "My Basket",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Reactive List of Items
          Expanded(
            child: Obx(() {
              if (basketController.items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_basket_outlined, size: 80.sp, color: Colors.grey),
                      SizedBox(height: 16.h),
                      Text("Your basket is empty", style: TextStyle(fontSize: 18.sp, color: Colors.grey)),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(24.r),
                itemCount: basketController.items.length,
                separatorBuilder: (context, index) => SizedBox(height: 24.h),
                itemBuilder: (context, index) {
                  final item = basketController.items[index];
                  return _buildOrderItem(item, index, basketController);
                },
              );
            }),
          ),

          // Footer / Checkout Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Obx(() => Text(
                      "৳ ${basketController.totalAmount.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF27214D),
                      ),
                    )),
                  ],
                ),
                Obx(() => ElevatedButton(
                  onPressed: basketController.items.isEmpty
                      ? null
                      : () {
                    Get.bottomSheet(
                      const CompleteDetailsBottomSheet(),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFA451),
                    padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: Text(
                    "Checkout",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(BasketItem item, int index, BasketController controller) {
    return Row(
      children: [
        Container(
          height: 65.h,
          width: 65.w,
          decoration: BoxDecoration(
            color: item.product.backgroundColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Image.asset(item.product.image, fit: BoxFit.contain),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF27214D),
                ),
              ),
              Text(
                "${item.quantity} packs",
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "৳ ${item.totalItemPrice.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF27214D),
              ),
            ),
            GestureDetector(
              onTap: () => controller.removeAt(index),
              child: Text(
                "Remove",
                style: TextStyle(fontSize: 12.sp, color: Colors.red.shade400),
              ),
            ),
          ],
        ),
      ],
    );
  }
}