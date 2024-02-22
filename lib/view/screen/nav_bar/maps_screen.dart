import 'dart:async';

import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widget/floating_search_bar.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  Completer<GoogleMapController> mapController = Completer();
  static Position? position;
  static final CameraPosition myCurrrentPositionCameraPosition = CameraPosition(
      bearing: 0,
      target: LatLng(position!.latitude, position!.longitude),
      tilt: 0.0,
      zoom: 17);
  Future<void> getCurrentLocation() async {
    await LocationHelper.determineCurrentPosition();
    position = await Geolocator.getCurrentPosition().whenComplete(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(position!.latitude, position!.longitude),
        zoom: 15.0,
      ),
      circles: {
        Circle(
          circleId: const CircleId("current_location"),
          center: LatLng(position!.latitude, position!.longitude),
          radius: 25,
          fillColor: MyColors.blue.withOpacity(0.3),
          strokeColor: MyColors.blue.withOpacity(0.4),
          strokeWidth: 2,
        ),
      },
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
      },
    );
  }

  Future<void> goToMyCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(myCurrrentPositionCameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            position != null
                ? buildMap()
                : const Center(
                    child: CircularProgressIndicator(
                      color: MyColors.green,
                    ),
                  ),
            const MyFloatingSearchBar(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.green,
          heroTag: 1,
          onPressed: goToMyCurrentLocation,
          child: const Icon(
            Icons.zoom_in_map_rounded,
            color: MyColors.white,
          ),
        ));
  }
}
