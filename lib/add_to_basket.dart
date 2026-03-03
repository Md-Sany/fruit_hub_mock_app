import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'basket_list_sheet.dart';
import 'model/product.dart';
import 'model/basket_manager.dart';
import 'package:get/get.dart';

class AddToBasket extends StatelessWidget {
  final Product product;

  // Local reactive variable for quantity
  final RxInt quantity = 1.obs;

  AddToBasket({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final BasketController basketController = Get.find();
    final ProductController productController = Get.find();

    return Scaffold(
      backgroundColor: const Color(0xffFFA451),
      body: Column(
        children: [
          SizedBox(
            height: 350.h,
            child: Stack(
              children: [
                Positioned(
                  top: 50.h,
                  left: 24.w,
                  child: GestureDetector(
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
                          Text("Go back", style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Hero(
                      tag: product.id,
                      child: Image.asset(product.image, height: 200.h)
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: const Color(0xFF27214D)),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _buildQuantityBtn(Icons.remove, () {
                            if (quantity.value > 1) quantity.value--;
                          }),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Obx(() => Text(
                              "${quantity.value}",
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                            )),
                          ),
                          _buildQuantityBtn(Icons.add, () => quantity.value++,
                              color: const Color(0xffFFF2E7),
                              iconColor: const Color(0xffFFA451)
                          ),
                        ],
                      ),
                      Text(
                        "৳ ${product.price}",
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: const Color(0xFF27214D)),
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  Text(
                    "One Pack Contains:",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF27214D)),
                  ),
                  Container(
                    width: 150.w,
                    height: 2.h,
                    color: const Color(0xffFFA451),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        product.description,
                        style: TextStyle(fontSize: 14.sp, color: const Color(0xFF27214D), height: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Obx(() => GestureDetector(
                        onTap: () => productController.toggleFavorite(product.id),
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF7F0),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            productController.isFavorite(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: const Color(0xffFFA451),
                            size: 28.sp,
                          ),
                        ),
                      )),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            basketController.addToBasket(product, quantity.value);
                            Get.bottomSheet(
                              const BasketListSheet(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFA451),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          ),
                          child: Text(
                            "Add to basket",
                            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityBtn(IconData icon, VoidCallback onTap, {Color? color, Color? iconColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: color == null ? Border.all(color: Colors.grey.shade300) : null,
          color: color,
        ),
        child: Icon(icon, size: 20.sp, color: iconColor ?? Colors.black),
      ),
    );
  }
}