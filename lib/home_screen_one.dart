import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'add_to_basket.dart';
import 'model/basket_manager.dart';
import 'order_list.dart';
import 'model/product.dart';
import 'favorites_screen.dart';
import 'track_order.dart';
import 'controller/user_controller.dart';

class HomeScreenOne extends StatefulWidget {
  const HomeScreenOne({super.key});

  @override
  State<HomeScreenOne> createState() => _HomeScreenOneState();
}

class _HomeScreenOneState extends State<HomeScreenOne> {
  final UserController userController = Get.find();
  final ProductController productController = Get.put(ProductController());
  final BasketController basketController = Get.put(BasketController());

  final List<String> _list = ['Hottest', 'Popular', 'New combo', 'Top'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              _buildTopBar(context),
              SizedBox(height: 24.h),
              _buildGreeting(),
              SizedBox(height: 24.h),
              _buildSearchBar(),
              SizedBox(height: 32.h),
              Text(
                'Recommended Combo',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              _buildRecommendedList(),
              SizedBox(height: 40.h),
              _buildFilterBar(),
              SizedBox(height: 20.h),
              _buildFilteredList(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Obx(
          () => RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 20.sp,
            color: const Color(0xFF27214D),
          ),
          children: [
            TextSpan(text: 'Hello ${userController.userName.value}, '),
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
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.drag_handle, size: 32.sp),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(() => const OrderList()),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset('assets/Group 25.png', width: 44.w),
              Obx(() => basketController.items.isEmpty
                  ? const SizedBox.shrink()
                  : Positioned(
                right: -5,
                top: -5,
                child: CircleAvatar(
                  radius: 10.r,
                  backgroundColor: const Color(0xffFFA451),
                  child: Text(
                    '${basketController.items.length}',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedList() {
    return SizedBox(
      height: 200.h,
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productController.recommended.length,
        itemBuilder: (context, index) {
          final product = productController.recommended[index];
          return GestureDetector(
            onTap: () => Get.to(() => AddToBasket(product: product)),
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              // Recommended should always be white/transparent background
              child: _buildStandardCard(product, false),
            ),
          );
        },
      )),
    );
  }

  Widget _buildFilteredList() {
    return SizedBox(
      height: 200.h,
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productController.filtered.length,
        itemBuilder: (context, index) {
          final product = productController.filtered[index];

          // Show background only for the 1st item (index == 0)
          // and not if the 'Top' filter (index 3) is selected
          bool showBackground = index == 0 && productController.selectedFilterIndex.value != 3;

          return GestureDetector(
            onTap: () => Get.to(() => AddToBasket(product: product)),
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: _buildStandardCard(product, showBackground),
            ),
          );
        },
      )),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xffFFA451)),
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
                Obx(() => Text(
                  'Hello, ${userController.userName.value}',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Color(0xffFFA451)),
            title: const Text('My Favorites'),
            onTap: () {
              Get.back();
              Get.to(() => const FavoritesScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping, color: Color(0xffFFA451)),
            title: const Text('Track Order'),
            onTap: () {
              Get.back();
              Get.to(() => const TrackOrder());
            },
          ),
          const Divider(),
        ],
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
          return Obx(() {
            final isSelected = index == productController.selectedFilterIndex.value;
            return GestureDetector(
              onTap: () => productController.updateFilter(index),
              child: Container(
                margin: EdgeInsets.only(right: 25.w),
                decoration: BoxDecoration(
                  border: isSelected ? Border(bottom: BorderSide(color: const Color(0xFFFFA451), width: 2.h)) : null,
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
          });
        },
      ),
    );
  }

  Widget _buildStandardCard(Product product, bool showBackground) {
    return Container(
      width: 155.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: showBackground ? (product.backgroundColor ?? Colors.white) : Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: showBackground
            ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ]
            : null,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => productController.toggleFavorite(product.id),
              child: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
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
                  basketController.addToBasket(product, 1);
                  Get.snackbar(
                    "Added!",
                    "${product.name} added to basket",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFFFFF2E7),
                    colorText: const Color(0xffFFA451),
                  );
                },
                child: CircleAvatar(
                  radius: 12.r,
                  backgroundColor: const Color(0xffFFF2E7),
                  child: Icon(Icons.add, color: const Color(0xffFFA451), size: 16.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}