import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vendors/common/background_container.dart';
import 'package:vendors/common/custom_button.dart';
import 'package:vendors/common/reusable_text.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/controllers/restaurant_controller.dart';
import 'package:vendors/controllers/uploader_controller.dart';
import 'package:vendors/models/restaurant_request.dart';
import 'package:vendors/views/auth/widgets/email_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:vendors/views/auth/widgets/map_btn.dart';

class RestauranteRegistration extends StatefulWidget {
  const RestauranteRegistration({super.key});

  @override
  State<RestauranteRegistration> createState() =>
      _RestauranteRegistrationState();
}

class _RestauranteRegistrationState extends State<RestauranteRegistration> {
  final box = GetStorage();
  late final PageController _pageController = PageController(initialPage: 0);
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  List<dynamic> _placeList = [];
  List<dynamic> _selectedPlaceList = [];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    _title.dispose();
    _time.dispose();
    _address.dispose();
    _postalCode.dispose();
    super.dispose();
  }

  LatLng? _selectedLocation;

  void _getPlaceDetails(String placeId) async {
    var placeDetailsUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey');

    final response = await http.get(placeDetailsUrl);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      final lat = responseBody['result']['geometry']['location']['lat'];
      final lng = responseBody['result']['geometry']['location']['lng'];

      final address = responseBody['result']['formatted_address'];

      String postalCode = '';
      final addressComponent = responseBody['result']['address_components'];

      for (var component in addressComponent) {
        if (component['types'].contains('postal_code')) {
          postalCode = component['long_name'];
          break;
        }
      }

      setState(() {
        _selectedLocation = LatLng(lat, lng);
        _searchController.text = address;
        _postalCode.text = postalCode;
        _placeList = [];
        moveToSelection();
      });
    }
  }

  void moveToSelection() {
    if (_selectedLocation != null && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _selectedLocation!, zoom: 15)));
    }
  }

  void _onSearchChanged(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      final url = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchQuery&key=$googleApiKey");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        setState(() {
          _placeList = [];
        });
      }
    }
  }

  void _onMarkerDragEnd(LatLng coords) async {
    setState(() {
      _selectedLocation = coords;
    });

    var reverseGeoCodingUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coords.latitude},${coords.longitude}&key=$googleApiKey');

    final response = await http.get(reverseGeoCodingUrl);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      final address = responseBody['results'][0]['formatted_address'];

      String postalCode = '';

      final addressComponent = responseBody['results'][0]['address_components'];

      for (var component in addressComponent) {
        if (component['types'].contains('postal_code')) {
          postalCode = component['long_name'];
          break;
        }
      }

      setState(() {
        _searchController.text = address;
        _postalCode.text = postalCode;
      });
    } else {
      debugPrint("Error getting thhe details");
    }
  }

  @override
  Widget build(BuildContext context) {
    final uploader = Get.put(UploaderController());
    final controller = Get.put(RestaurantController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kPrimary,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MapBtn(
              text: 'Atras',
              onTap: () {
                _pageController.previousPage(
                    duration: const Duration(milliseconds: 552),
                    curve: Curves.easeIn);
              },
            ),
            const ResuableText(
                text: "Registrar Restaurante",
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: kWhite)),
            MapBtn(
              text: 'Siguiente',
              onTap: () {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 480),
                    curve: Curves.easeIn);
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BackGroundContainer(
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                        target: _selectedLocation ??
                            const LatLng(6.50166666, -75.743333),
                        zoom: 16),
                    markers: _selectedLocation == null
                        ? Set.of([])
                        : Set.of([
                            Marker(
                                markerId: const MarkerId("Tu Ubicacion"),
                                position: _selectedLocation!,
                                draggable: true,
                                onDragEnd: (LatLng position) {
                                  _onMarkerDragEnd(position);
                                })
                          ]),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        color: Colors.white,
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: kGray,
                                  fontWeight: FontWeight.w400),
                              hintText: 'Buscar tu direccion . . .'),
                        ),
                      ),
                      _placeList.isEmpty
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: ListView(
                              children:
                                  List.generate(_placeList.length, (index) {
                                return Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(
                                      _placeList[index]['description'],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: kDark,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    visualDensity: VisualDensity.compact,
                                    onTap: () {
                                      _getPlaceDetails(
                                          _placeList[index]['place_id']);
                                      _selectedPlaceList.add(_placeList[index]);
                                    },
                                  ),
                                );
                              }),
                            ))
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: height,
              child: BackGroundContainer(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Image One
                        GestureDetector(
                            onTap: () {
                              uploader.pickImage('logo');
                            },
                            child: Obx(
                              () => Container(
                                  height: 120.h,
                                  width: width / 2.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: kGrayLight)),
                                  child: uploader.logoUrl == ''
                                      ? Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.camera_alt,
                                                color: kGray,
                                                size: 26,
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              const Text(
                                                "Subir Logo",
                                                style: TextStyle(
                                                    color: kGray, fontSize: 14),
                                              )
                                            ],
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          child: Image.network(
                                            uploader.logoUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                            )),
                        GestureDetector(
                            onTap: () {
                              uploader.pickImage('cover');
                            },
                            child: Obx(
                              () => Container(
                                  height: 120.h,
                                  width: width / 2.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: kGrayLight)),
                                  child: uploader.coverUrl == ''
                                      ? Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.camera_alt,
                                                color: kGray,
                                                size: 26,
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              const Text(
                                                "Subir Imagen",
                                                style: TextStyle(
                                                    color: kGray, fontSize: 14),
                                              )
                                            ],
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          child: Image.network(
                                            uploader.coverUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    EmailTextField(
                      prefixIcon: const Icon(
                        AntDesign.edit,
                        size: 19,
                        color: kGray,
                      ),
                      controller: _title,
                      hintText: 'Nombre de tu Restaurante',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    EmailTextField(
                      prefixIcon: const Icon(
                        Icons.lock_clock,
                        size: 19,
                        color: kGray,
                      ),
                      controller: _time,
                      hintText: 'Horario ej : 5PM - 10:30PM',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    EmailTextField(
                      prefixIcon: const Icon(
                        AntDesign.edit,
                        size: 15,
                        color: kGray,
                      ),
                      controller: _searchController,
                      hintText: 'Direccion',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    EmailTextField(
                      prefixIcon: const Icon(
                        AntDesign.edit,
                        size: 15,
                        color: kGray,
                      ),
                      controller: _postalCode,
                      hintText: 'Postal Code',
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomButton(
                      btnHeight: 36.h,
                      text: "A G R E G A R    R E S T A U R A N T E ",
                      onTap: () {
                        if (_time.text.isEmpty ||
                            _title.text.isEmpty ||
                            _searchController.text.isEmpty ||
                            uploader.logoUrl.isEmpty ||
                            uploader.coverUrl.isEmpty) {
                          Get.snackbar('Error', 'Campos faltan por llenar',
                              backgroundColor: kPrimary,
                              colorText: Colors.white);
                        }
                        String owner = box.read('userId');
                        print(owner);

                        RestaurantRequest model = RestaurantRequest(
                            title: _title.text,
                            time: _time.text,
                            imageUrl: uploader.coverUrl,
                            owner: owner,
                            code: _postalCode.text,
                            logoUrl: uploader.logoUrl,
                            coords: Coords(
                              id: controller.generateId().toString(),
                              latitude: _selectedLocation!.latitude,
                              longitude: _selectedLocation!.longitude,
                              address: _searchController.text,
                              title: _title.text,
                            ));
                        String data = restaurantRequestToJson(model);
                        controller.restaurantRegistration(data);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
