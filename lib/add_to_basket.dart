import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'basket_list_sheet.dart';
import 'model/product.dart';
import 'model/basket_manager.dart';
import 'package:get/get.dart';

class AddToBasket extends StatefulWidget {
  final Product product;

  const AddToBasket({super.key, required this.product});

  @override
  State<AddToBasket> createState() => _AddToBasketState();
}

class _AddToBasketState extends State<AddToBasket> {
  // 1. Find the existing Controller instances
  final BasketController basketController = Get.find<BasketController>();
  final ProductController productController = Get.find<ProductController>();

  // 2. Quantity as an observable
  final RxInt quantity = 1.obs;

  double get unitPrice => double.parse(widget.product.price.replaceAll(',', ''));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFA451),
      body: Column(
        children: [
          // Header & Image Section
          SizedBox(
            height: 350.h,
            child: Stack(
              children: [
                Positioned(
                  top: 50.h,
                  left: 24.w,
                  child: GestureDetector(
                    onTap: () => Get.back(), // Use GetX navigation
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios, size: 16.sp, color: Colors.black),
                          Text("Go back", style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Hero(
                    tag: widget.product.id,
                    child: Image.asset(
                      widget.product.image,
                      height: 200.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Details Section
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF27214D),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Quantity and Dynamic Price Row
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
                            // 3. Wrap quantity text in Obx
                            child: Obx(() => Text(
                                "${quantity.value}",
                                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)
                            )),
                          ),
                          _buildQuantityBtn(Icons.add, () => quantity.value++,
                              color: const Color(0xffFFF2E7), iconColor: const Color(0xffFFA451)),
                        ],
                      ),
                      // 4. Wrap total price in Obx
                      Obx(() => Text(
                        "৳ ${(unitPrice * quantity.value).toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: const Color(0xFF27214D)),
                      )),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  const Divider(color: Color(0xffFFA451), thickness: 1, endIndent: 200),
                  SizedBox(height: 20.h),
                  Text(
                    "One Pack Contains:",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: const Color(0xFF27214D)),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        widget.product.description,
                        style: TextStyle(fontSize: 14.sp, color: const Color(0xFF27214D), height: 1.5),
                      ),
                    ),
                  ),

                  // Bottom Buttons Row
                  SafeArea(
                    child: Row(
                      children: [
                        // 5. Reactive Favorite Button
                        Obx(() {
                          bool isFav = productController.isFavorite(widget.product.id);
                          return GestureDetector(
                            onTap: () => productController.toggleFavorite(widget.product.id),
                            child: Container(
                              padding: EdgeInsets.all(12.r),
                              decoration: const BoxDecoration(
                                color: Color(0xffFFF2E7),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: const Color(0xffFFA451),
                                  size: 28.sp
                              ),
                            ),
                          );
                        }),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // 6. Use the basketController instance
                              basketController.addToBasket(widget.product, quantity.value);

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
          border: color == null ? Border.all(color: Colors.grey) : null,
          color: color,
        ),
        child: Icon(icon, size: 20.sp, color: iconColor ?? Colors.black),
      ),
    );
  }
}