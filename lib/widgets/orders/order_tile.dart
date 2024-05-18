import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendors/common/reusable_text.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/models/orders_model.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.order,
  });

  final OrdersModel order;

  @override
  Widget build(BuildContext context) {
    // final location = Get.put(UserLocationController());
    // final controller = Get.put(OrdersController());
    // DistanceTime distance = Distance().calculateDistanceTimePrice(
    //     location.currentLocation.latitude,
    //     location.currentLocation.longitude,
    //     order.restaurantCoords[0],
    //     order.restaurantCoords[1],
    //     5,
    //     5);

    // DistanceTime distance2 = Distance().calculateDistanceTimePrice(
    //     order.restaurantCoords[0],
    //     order.restaurantCoords[1],
    //     order.recipientCoords[0],
    //     order.recipientCoords[1],
    //     15,
    //     5);

    // double distanceToRestaurant = distance.distance + 1;
    // double distanceFromRestaurantToClient = distance2.distance + 1;

    return GestureDetector(
      onTap: () {
        // controller.order = order;
        // controller.setDistance =
        //     distanceToRestaurant + distanceFromRestaurantToClient;

        //  Get.to(() => const ActivePage(),
        //         transition: Transition.fadeIn,
        //         duration: const Duration(seconds: 2));
        //     activeOrder = const ActivePage();
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 84,
            width: width,
            decoration: BoxDecoration(
                color: kLightWhite,
                borderRadius: BorderRadius.all(Radius.circular(9.r))),
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: SizedBox(
                        height: 75.h,
                        width: 70.h,
                        child: Image.network(
                          order.orderItems[0].foodId.imageUrl[0],
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      ResuableText(
                          text: order.orderItems[0].foodId.title,
                          style: const TextStyle(
                              fontSize: 10,
                              color: kGray,
                              fontWeight: FontWeight.w500)),
                      OrderRowText(text: "🍲 Orden : ${order.id}"),
                      OrderRowText(
                          text: "🏠 ${order.deliveryAddress.addressLine1}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            margin: EdgeInsets.only(right: 2.w),
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(10)),
                            child: ResuableText(
                                text: "\$ ${order.deliveryFee}",
                                style: const TextStyle(
                                    fontSize: 9,
                                    color: kGray,
                                    fontWeight: FontWeight.w400)),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            margin: EdgeInsets.only(right: 2.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: const ResuableText(
                                text: "⏰ 25 min",
                                style: TextStyle(
                                    fontSize: 9,
                                    color: kGray,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 10.h,
              top: 6.h,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: SizedBox(
                  width: 19.h,
                  height: 19.h,
                  child: Image.network(order.restaurantId.logoUrl,
                      fit: BoxFit.cover),
                ),
              ))
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class OrderRowText extends StatelessWidget {
  OrderRowText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width / 1.6,
        child: ResuableText(
            text: text,
            style: const TextStyle(
                fontSize: 9, color: kGray, fontWeight: FontWeight.w400)));
  }
}
