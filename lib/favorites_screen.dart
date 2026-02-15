import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/product.dart';
import 'model/basket_manager.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    // Combine product lists and filter favorites
    final allProducts = [...recommendedProducts, ...filteredProducts];
    final favoriteProducts = allProducts
        .where((p) => ProductManager().isFavorite(p.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom Header Style
          Container(
            height: 160.h,
            padding: EdgeInsets.only(top: 30.h, left: 24.w),
            decoration: const BoxDecoration(color: Color(0xffFFA451)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 14.sp, color: Colors.black),
                        Text("Go back",
                            style: TextStyle(fontSize: 14.sp, color: Colors.black)
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
                Text(
                  "My Favorites",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: favoriteProducts.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
              padding: EdgeInsets.all(24.r),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                return _buildFavoriteCard(favoriteProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          Text("No favorites yet!",
              style: TextStyle(fontSize: 18.sp, color: Colors.grey)
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(Product product) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: product.backgroundColor,
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
              onTap: () {
                setState(() {
                  ProductManager().toggleFavorite(product.id);
                });
              },
              child: Icon(
                  Icons.favorite,
                  color: const Color(0xffFFA451),
                  size: 20.sp
              ),
            ),
          ),
          Expanded(child: Image.asset(product.image, fit: BoxFit.contain)),
          SizedBox(height: 8.h),
          Text(
            product.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "৳${product.price}",
            style: TextStyle(
                color: const Color(0xFFF08626),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}