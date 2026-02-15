import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/basket_manager.dart';
import 'complete_details.dart';

class BasketListSheet extends StatefulWidget {
  const BasketListSheet({super.key});

  @override
  State<BasketListSheet> createState() => _BasketListSheetState();
}

class _BasketListSheetState extends State<BasketListSheet> {
  final basket = BasketManager();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        // Main Container (Styled like CompleteDetails)
        Container(
          margin: EdgeInsets.only(top: 80.h),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.7, // Set a fixed height for the sheet
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

              // Scrollable List (Styled like OrderList)
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
                    return _buildBasketItem(item, index);
                  },
                ),
              ),

              // Bottom Action Bar
              if (basket.items.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      )
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Total", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                            Text(
                              "৳ ${basket.totalAmount.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF27214D),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close this sheet
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const CompleteDetailsBottomSheet(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFA451),
                            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          ),
                          child: Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Floating Close Button (From CompleteDetails)
        Positioned(
          top: 20.h,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 48.r,
              width: 48.r,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.black, size: 24.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBasketItem(BasketItem item, int index) {
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
        padding: const EdgeInsets.only(right: 8.0),
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
            Text(
              "৳ ${item.totalItemPrice.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF27214D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}