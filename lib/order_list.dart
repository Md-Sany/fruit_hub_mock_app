import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'complete_details.dart';
import 'model/basket_manager.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final basket = BasketManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
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
                        Text("Go back", style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 40.w),
                Text(
                  "My Basket",
                  style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          // Basket List
          Expanded(
            child: basket.items.isEmpty
                ? const Center(child: Text("Your basket is empty"))
                : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              itemCount: basket.items.length,
              separatorBuilder: (context, index) => Divider(
                color: const Color(0xFFF4F4F4),
                thickness: 2,
                height: 32.h,
              ),
              itemBuilder: (context, index) {
                final item = basket.items[index];
                return Dismissible(
                  key: Key(item.product.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      basket.removeAt(index);
                    });
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w,),
                    child: Row(
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
                                    color: const Color(0xFF27214D)
                                ),
                              ),
                              Text(
                                "${item.quantity} packs",
                                style: TextStyle(fontSize: 14.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "৳ ${item.product.price}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF27214D)
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Total & Checkout
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                      Text(
                        "৳ ${basket.totalAmount.toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: const Color(0xFF27214D)),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent, // Required to see the floating button
                        builder: (context) => const CompleteDetailsBottomSheet(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFFA451),
                      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 16.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  ),
                ],
              ),
            ),
          ),
         //SizedBox(height: 20.h),
        ],
      ),
    );
  }
}