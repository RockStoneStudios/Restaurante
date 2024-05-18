import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendors/common/shimmers/foodlist_shimmer.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/hooks/orders_hook.dart';
import 'package:vendors/widgets/orders/order_tile.dart';

class NewOrders extends HookWidget {
  const NewOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = fetchOrders('Placed');
    final isLoading = hookResults.isLoading;
    final data = hookResults.data;
    final error = hookResults.error;

    if (isLoading) {
      return const FoodsListShimmer();
    }

    if (error != null) {
      return Center(
        child: Text(error.message),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r), topRight: Radius.circular(14.r)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: kGray.withOpacity(0.32)),
        child: ListView(
          children: List.generate(data!.length, (index) {
            final order = data[index];
            return Container(
              padding: EdgeInsets.only(bottom: 8.h),
              child: OrderTile(order: order),
            );
          }),
        ),
      ),
    );
  }
}
