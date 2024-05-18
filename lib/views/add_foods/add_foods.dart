import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendors/common/background_container.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/controllers/food_controller.dart';
import 'package:vendors/controllers/restaurant_controller.dart';
import 'package:vendors/controllers/uploader_controller.dart';

import 'package:vendors/models/add_foods_model.dart';
import 'package:vendors/views/add_foods/widgets/additives_info.dart';
import 'package:vendors/views/add_foods/widgets/all_categories.dart';
import 'package:vendors/views/add_foods/widgets/food_info.dart';
import 'package:vendors/views/add_foods/widgets/image_uploads.dart';

class AddFoods extends StatefulWidget {
  const AddFoods({super.key});

  @override
  State<AddFoods> createState() => _AddFoodsState();
}

class _AddFoodsState extends State<AddFoods> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController preparation = TextEditingController();
  final TextEditingController types = TextEditingController();
  final TextEditingController additivePrice = TextEditingController();
  final TextEditingController additiveTitle = TextEditingController();
  final TextEditingController foodTags = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    price.dispose();
    preparation.dispose();
    types.dispose();
    additiveTitle.dispose();
    additivePrice.dispose();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController());
    final images = Get.put(UploaderController());
    final restaurant = Get.put(RestaurantController());
    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        backgroundColor: kSecondary,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: kWhite,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Bienvenido al Panel Restaurante',
          style: TextStyle(
              fontSize: 18, color: kWhite, fontWeight: FontWeight.w700),
        ),
      ),
      body: BackGroundContainer(
          child: ListView(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: PageView(
              controller: _pageController,
              pageSnapping: false,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ChooseCategory(
                  next: () {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 510),
                        curve: Curves.easeIn);
                  },
                ),
                ImageUploads(
                  back: () {
                    _pageController.previousPage(
                        duration: const Duration(milliseconds: 510),
                        curve: Curves.easeIn);
                  },
                  next: () {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 510),
                        curve: Curves.easeIn);
                  },
                ),
                FoodInfo(
                    title: title,
                    description: description,
                    price: price,
                    types: types,
                    preparation: preparation,
                    back: () {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 510),
                          curve: Curves.easeIn);
                    },
                    next: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 510),
                          curve: Curves.easeIn);
                    }),
                AdditivesInfo(
                  additiveTitle: additiveTitle,
                  additivePrice: additivePrice,
                  foodTags: foodTags,
                  back: () {
                    _pageController.previousPage(
                        duration: const Duration(milliseconds: 510),
                        curve: Curves.easeIn);
                  },
                  submit: () {
                    if (title.text.isEmpty ||
                        price.text.isEmpty ||
                        preparation.text.isEmpty ||
                        description.text.isEmpty ||
                        controller.types.isEmpty ||
                        controller.tags.isEmpty ||
                        controller.additivesList.isEmpty) {
                      Get.snackbar(
                          backgroundColor: kPrimary,
                          colorText: kLightWhite,
                          'Debes Llenar todos los campos',
                          'Todos los campos son obligatorios para cargar alimentos en la aplicación.');
                    } else {
                      AddFoodsModel foodItem = AddFoodsModel(
                          title: title.text,
                          foodTags: controller.tags,
                          foodType: controller.types,
                          code: restaurant.restaurant!.code,
                          category: controller.category,
                          time: preparation.text,
                          isAvailable: true,
                          restaurant: restaurant.restaurant!.id,
                          description: description.text,
                          price: double.parse(price.text),
                          additives: controller.additivesList,
                          imageUrl: images.images);
                      String data = addFoodsModelToJson(foodItem);
                      controller.addFoodsFunction(data);
                      images.resetList();
                      controller.additivesList.clear();
                      controller.tags.clear();
                      controller.types.clear();
                    }
                  },
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
