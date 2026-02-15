import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/product.dart';
import 'model/basket_manager.dart';
import 'order_list.dart';

class AddToBasket extends StatefulWidget {
  final Product product;

  const AddToBasket({super.key, required this.product});

  @override
  State<AddToBasket> createState() => _AddToBasketState();
}

class _AddToBasketState extends State<AddToBasket> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    // Get the latest favorite status from the manager
    bool currentFavoriteStatus = ProductManager().isFavorite(widget.product.id);

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
                    onTap: () => Navigator.pop(context),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _buildQuantityBtn(Icons.remove, () {
                            if (quantity > 1) setState(() => quantity--);
                          }),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text("$quantity", style: TextStyle(fontSize: 20.sp)),
                          ),
                          _buildQuantityBtn(Icons.add, () {
                            setState(() => quantity++);
                          }, color: const Color(0xffFFF2E7), iconColor: const Color(0xffFFA451)),
                        ],
                      ),
                      Text(
                        "৳ ${widget.product.price}",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF27214D),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Divider(color: Colors.grey.withOpacity(0.2)),
                  SizedBox(height: 20.h),
                  Text(
                    "One Pack Contains:",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xffFFA451),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Red Quinoa, Lime, Honey, Blueberries, Strawberries, Mango, Fresh mint.",
                    style: TextStyle(fontSize: 14.sp, color: const Color(0xFF27214D)),
                  ),
                  const Spacer(),
                  SafeArea(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ProductManager().toggleFavorite(widget.product.id);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFF2E7),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                                currentFavoriteStatus ? Icons.favorite : Icons.favorite_border,
                                color: const Color(0xffFFA451),
                                size: 28.sp
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              BasketManager().addToBasket(widget.product, quantity);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Added to basket!"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => const OrderList(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFFA451),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            ),
                            child: Text(
                              "Add to basket",
                              style: TextStyle(color: Colors.white, fontSize: 16.sp),
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