class PlaceLocationModel {
  final double lat;
  final double lng;

  PlaceLocationModel({required this.lat, required this.lng});

  factory PlaceLocationModel.fromJson(Map<String, dynamic> json) {
    final result = json['result'];
    final geometry = result['geometry'];
    final location = geometry['location'];

    return PlaceLocationModel(
      lat: location['lat'],
      lng: location['lng'],
    );
  }
}
