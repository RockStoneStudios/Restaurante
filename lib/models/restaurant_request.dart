import 'dart:convert';

RestaurantRequest restaurantRequestFromJson(String str) =>
    RestaurantRequest.fromJson(json.decode(str));

String restaurantRequestToJson(RestaurantRequest data) =>
    json.encode(data.toJson());

class RestaurantRequest {
  String title;
  String time;
  String imageUrl;
  String owner;
  String code;
  String logoUrl;
  Coords coords;

  RestaurantRequest({
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.owner,
    required this.code,
    required this.logoUrl,
    required this.coords,
  });

  factory RestaurantRequest.fromJson(Map<String, dynamic> json) =>
      RestaurantRequest(
        title: json["title"],
        time: json["time"],
        imageUrl: json["imageUrl"],
        owner: json["owner"],
        code: json["code"],
        logoUrl: json["logoUrl"],
        coords: Coords.fromJson(json["coords"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "time": time,
        "imageUrl": imageUrl,
        "owner": owner,
        "code": code,
        "logoUrl": logoUrl,
        "coords": coords.toJson(),
      };
}

class Coords {
  String id;
  double latitude;
  double longitude;
  String address;
  String title;

  Coords({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.title,
  });

  factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "title": title,
      };
}
