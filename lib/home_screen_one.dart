import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'add_to_basket.dart';
import 'model/basket_manager.dart';
import 'order_list.dart';
import 'model/product.dart';
import 'favorites_screen.dart';
import 'track_order.dart';

class HomeScreenOne extends StatefulWidget {
  final String userName;

  const HomeScreenOne({super.key, this.userName = "Tony"});

  @override
  State<HomeScreenOne> createState() => _HomeScreenOneState();
}

class _HomeScreenOneState extends State<HomeScreenOne> {
  final List<String> _list = ['Hottest', 'Popular', 'New combo', 'Top'];
  int _selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xffFFA451),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40.sp, color: const Color(0xffFFA451)),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Hello, ${widget.userName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // 1. My Favorites Tile
            ListTile(
              leading: const Icon(Icons.favorite, color: Color(0xffFFA451)),
              title: Text(
                'My Favorites',
                style: TextStyle(fontSize: 16.sp, color: const Color(0xFF27214D)),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                ).then((_) => setState(() {})); // Refresh home screen state when returning
              },
            ),

            // 2. Track Order Tile
            ListTile(
              leading: const Icon(Icons.local_shipping, color: Color(0xffFFA451)),
              title: Text(
                'Track Order',
                style: TextStyle(fontSize: 16.sp, color: const Color(0xFF27214D)),
              ),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TrackOrder()),
                );
              },
            ),

            const Divider(), // Visual separator
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.drag_handle, size: 32.sp),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => OrderList()),
                      );
                    },
                    child: Image.asset('assets/Group 25.png', width: 44.w),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color(0xFF27214D),
                  ),
                  children: [
                    TextSpan(text: 'Hello ${widget.userName}, '),
                    TextSpan(
                      text: 'What fruit salad combo do you want today?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              _buildSearchBar(),
              SizedBox(height: 32.h),
              Text(
                'Recommended Combo',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedProducts.length,
                  itemBuilder: (context, index) {
                    final product = recommendedProducts[index];

                    return GestureDetector(
                      key: ValueKey(product.id),
                      onTap: () async {
                        // Use 'await' to wait for the AddToBasket screen to be popped
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddToBasket(product: product),
                          ),
                        );

                        // This line runs AFTER you come back from the AddToBasket screen
                        if (mounted) {
                          setState(() {}); // This refreshes the favorite icons on the Home Screen
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: _buildStandardCard(recommendedProducts[index]),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 40.h),
              _buildFilterBar(),
              SizedBox(height: 20.h),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];

                    return GestureDetector(
                      key: ValueKey(product.id),
                      onTap: () async {
                        // Use 'await' to wait for the AddToBasket screen to be popped
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddToBasket(product: product),
                          ),
                        );
                        // This line runs AFTER you come back from the AddToBasket screen
                        if (mounted) {
                          setState(() {}); // This refreshes the favorite icons on the Home Screen
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: _buildStandardCard(filteredProducts[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F9),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey, size: 24.sp),
                SizedBox(width: 10.w),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Icon(Icons.tune, size: 26.sp),
      ],
    );
  }

  Widget _buildFilterBar() {
    return SizedBox(
      height: 35.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedFilterIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilterIndex = index),
            child: Container(
              margin: EdgeInsets.only(right: 25.w),
              decoration: BoxDecoration(
                border: isSelected
                    ? Border(
                        bottom: BorderSide(
                          color: const Color(0xFFFFA451),
                          width: 2.h,
                        ),
                      )
                    : null,
              ),
              child: Text(
                _list[index],
                style: TextStyle(
                  fontSize: isSelected ? 20.sp : 16.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? const Color(0xFF27214D) : Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStandardCard(Product product) {
    bool isFav = ProductManager().isFavorite(product.id);
    return Container(
      width: 155.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: product.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
                isFav ? Icons.favorite : Icons.favorite_border,
                color: const Color(0xffFFA451),
                size: 20.sp,
              ),
            ),
          ),
          Image.asset(product.image, height: 80.h, fit: BoxFit.contain),
          SizedBox(height: 10.h),
          Text(
            product.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "৳${product.price}",
                style: TextStyle(
                  color: const Color(0xFFF08626),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Adds 1 quantity of the product to the basket immediately
                  BasketManager().addToBasket(product, 1);

                  // Feedback for the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product.name} added to basket!"),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 12.r,
                  backgroundColor: const Color(0xffFFF2E7),
                  child: Icon(
                    Icons.add,
                    color: const Color(0xffFFA451),
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
