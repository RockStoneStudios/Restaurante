import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendors/common/background_container.dart';
import 'package:vendors/common/custom_appbar.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/widgets/home_tiles.dart';
import 'package:vendors/widgets/orders/cancelled_orders.dart';
import 'package:vendors/widgets/orders/deliverd_orders.dart';
import 'package:vendors/widgets/orders/new_orders.dart';
import 'package:vendors/widgets/orders/picked_orders.dart';
import 'package:vendors/widgets/orders/preparing.dart';
import 'package:vendors/widgets/orders/ready_orders.dart';
import 'package:vendors/widgets/orders/self_deliverys.dart';

import '../../widgets/home_tabs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: orderList.length, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: const CustomAppBar(),
      ),
      body: BackGroundContainer(
          child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 15.h,
          ),
          const HomeTiles(),
          SizedBox(
            height: 15.h,
          ),
          HomeTabs(tabController: _tabController),
          SizedBox(height: 15.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.transparent,
            ),
            height: height * 0.7,
            child: TabBarView(
              controller: _tabController,
              children: const [
                NewOrders(),
                Preparing(),
                ReadyOrders(),
                PickedUp(),
                SelfDeliveries(),
                DeliveredOrders(),
                CancelledOrders()
              ],
            ),
          )
        ],
      )),
    );
  }
}
