import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/models/foods_model.dart';

// ignore: must_be_immutable
class FoodTile extends StatelessWidget {
  FoodsModel food;

  FoodTile({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Container(
        height: 85.h,
        decoration: BoxDecoration(
            color: kOffWhite, borderRadius: BorderRadius.circular(12.r)),
        child: Stack(children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: SizedBox(
                  height: 80.h,
                  width: 80.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      food.imageUrl[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    food.title,
                    style: const TextStyle(
                        fontSize: 12,
                        color: kDark,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    " Tiempo Domicilio ${food.time}",
                    style: const TextStyle(
                        fontSize: 12,
                        color: kDark,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 18.h,
                    width: width * .7,
                    child: ListView.builder(
                        itemCount: food.additives.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          String additive = food.additives[index].title;
                          return Container(
                            margin: EdgeInsets.only(right: 5.w),
                            decoration: BoxDecoration(
                                color: kSecondaryLight,
                                borderRadius: BorderRadius.circular(9.r)),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  additive,
                                  style: const TextStyle(
                                      fontSize: 9,
                                      color: kGray,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              )
            ],
          ),
          Positioned(
              right: 5.w,
              top: 5.h,
              child: Container(
                height: 19.h,
                width: 68.w,
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    "\$ ${food.price.toStringAsFixed(0)}",
                    style: const TextStyle(color: kWhite, fontSize: 12),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
