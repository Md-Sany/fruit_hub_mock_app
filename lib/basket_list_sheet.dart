import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/basket_manager.dart';
import 'order_list.dart';
import 'package:get/get.dart';

class BasketListSheet extends StatelessWidget {
  const BasketListSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the existing BasketController
    final BasketController basketController = Get.find<BasketController>();

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        // The Sheet Background
        Container(
          margin: EdgeInsets.only(top: 80.h),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Text(
                "My Basket",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF27214D),
                ),
              ),

              // Reactive List Section
              Expanded(
                child: Obx(() {
                  if (basketController.items.isEmpty) {
                    return Center(
                      child: Text(
                        "Your basket is empty",
                        style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.all(24.r),
                    itemCount: basketController.items.length,
                    separatorBuilder: (context, index) => SizedBox(height: 24.h),
                    itemBuilder: (context, index) {
                      final item = basketController.items[index];
                      return _buildBasketItem(item, index, basketController);
                    },
                  );
                }),
              ),

              // Checkout Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
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
                        Get.back(); // Close bottom sheet
                        Get.to(() => const OrderList());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFFA451),
                        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                      child: Text(
                        "Go to Checkout",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Floating Close Button
        Positioned(
          top: 50.h,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.white,
              child: const Icon(Icons.close, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBasketItem(BasketItem item, int index, BasketController controller) {
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