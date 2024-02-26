import 'dart:async';
import 'dart:developer';

import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/location.dart';
import 'package:dr_ai/data/model/place_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../logic/maps/maps_cubit.dart';
import '../../widget/floating_search_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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

//!
  Set<Marker> markers = {};
  // late PlaceSuggestionModel placeSuggestion;
  late PlaceLocationModel selectedPlace;
  late Marker searchedPlaceMarker;
  late CameraPosition goToSearchedForPlace;

  void buildCameraNewPosition() {
    log("${selectedPlace.lat}  ${selectedPlace.lng}");
    goToSearchedForPlace = CameraPosition(
      bearing: 0.0,
      tilt: 0.0,
      target: LatLng(
        selectedPlace.lat,
        selectedPlace.lng,
      ),
      zoom: 13,
    );
  }

//!
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Widget buildMap() {
    return GoogleMap(
      markers: markers,
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
            buildSelectedPlaceLocationBloc(),
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

  Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is MapsLoadedLocationSuccess) {
          selectedPlace = state.placeLocationModel;
          log(selectedPlace.toString());
          goToMySearchedForLocation();
        }
      },
      child: Container(),
    );
  }

  Future<void> goToMySearchedForLocation() async {
    buildCameraNewPosition();
    final GoogleMapController controller = await mapController.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
    buildSearchedPlaceMarker();
  }

  void buildSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      position: goToSearchedForPlace.target,
      markerId: const MarkerId('1'),
      onTap: () {
        setState(() {});
      },
      infoWindow: InfoWindow(title: CacheData.getdata(key: "description")),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }
}
