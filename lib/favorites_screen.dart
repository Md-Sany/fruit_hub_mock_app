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
    final allProducts = [...recommendedProducts, ...filteredProducts];
    final favoriteProducts = allProducts.where((p) => ProductManager().isFavorite(p.id)).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffFFA451),
        elevation: 0,
        title: Text("My Favorites", style: TextStyle(fontSize: 20.sp, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: favoriteProducts.isEmpty
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
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          Text("No favorites yet!", style: TextStyle(fontSize: 18.sp, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(Product product) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: product.backgroundColor, //
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
              child: Icon(Icons.favorite, color: const Color(0xffFFA451), size: 20.sp),
            ),
          ),
          Expanded(child: Image.asset(product.image, fit: BoxFit.contain)), //
          SizedBox(height: 8.h),
          Text(
            product.name, //
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "৳${product.price}", //
            style: TextStyle(color: const Color(0xFFF08626), fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}