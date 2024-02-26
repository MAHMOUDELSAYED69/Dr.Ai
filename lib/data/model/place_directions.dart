import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class PlaceDirectionsModel {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  PlaceDirectionsModel({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });

  factory PlaceDirectionsModel.fromJson(Map<String, dynamic> json) {
    final data = json['routes'][0] as Map<String, dynamic>;

    final northeast = data['bounds']['northeast'] as Map<String, dynamic>;
    final southwest = data['bounds']['southwest'] as Map<String, dynamic>;

    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );

    late String distance;
    late String duration;

    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0] as Map<String, dynamic>;
      distance = leg['distance']['text'] as String;
      duration = leg['duration']['text'] as String;
    }

    return PlaceDirectionsModel(
      bounds: bounds,
      polylinePoints: PolylinePoints()
          .decodePolyline(data['overview_polyline']['points'] as String),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
