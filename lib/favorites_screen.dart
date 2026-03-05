import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'add_to_basket.dart';
import 'model/product.dart';
import 'model/basket_manager.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
                  "My Favorites",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              // Create a combined list and use a Set to filter out duplicate IDs
              final combinedList = [...productController.recommended, ...productController.filtered];
              final uniqueIds = <String>{};

              final favoriteProducts = combinedList.where((product) {
                if (product.isFavorite && !uniqueIds.contains(product.id)) {
                  uniqueIds.add(product.id);
                  return true;
                }
                return false;
              }).toList();

              if (favoriteProducts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 80.sp, color: Colors.grey.shade300),
                      SizedBox(height: 16.h),
                      Text(
                        "No favorites yet!",
                        style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                padding: EdgeInsets.all(24.r),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return _buildFavoriteCard(product, productController);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(Product product, ProductController controller) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: product.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => controller.toggleFavorite(product.id),
              child: Icon(
                Icons.favorite,
                color: const Color(0xffFFA451),
                size: 22.sp,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Get.to(() => AddToBasket(product: product)),
              child: Image.asset(product.image, fit: BoxFit.contain),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            product.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            "৳${product.price}",
            style: TextStyle(
              color: const Color(0xFFF08626),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}