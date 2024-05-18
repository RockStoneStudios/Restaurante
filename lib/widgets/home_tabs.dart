import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendors/common/tab_widget.dart';
import 'package:vendors/constant/constants.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Container(
        height: 26.h,
        width: width,
        decoration: BoxDecoration(
            color: kOffWhite, borderRadius: BorderRadius.circular(10.r)),
        child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: kPrimary,
              borderRadius: BorderRadius.circular(25.r),
            ),
            dividerColor: Colors.transparent,
            unselectedLabelColor: kGrayLight,
            labelColor: kLightWhite,
            labelPadding: EdgeInsets.zero,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            labelStyle: const TextStyle(
                fontSize: 13, color: kLightWhite, fontWeight: FontWeight.w800),
            unselectedLabelStyle: const TextStyle(
                fontSize: 13, color: kGrayLight, fontWeight: FontWeight.w600),
            tabs: List.generate(orderList.length, (index) {
              return TabWidget(text: orderList[index]);
            })),
      ),
    );
  }
}
