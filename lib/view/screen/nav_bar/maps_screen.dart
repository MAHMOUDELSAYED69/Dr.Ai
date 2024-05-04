import 'dart:async';
import 'dart:developer';
import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/core/helper/location.dart';
import 'package:dr_ai/data/model/place_directions.dart';
import 'package:dr_ai/data/model/place_location.dart';
import 'package:dr_ai/view/widget/directions_details_card.dart';
import 'package:dr_ai/view/widget/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../logic/maps/maps_cubit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    await LocationHelper.determineCurrentPosition();
    _position = await Geolocator.getCurrentPosition().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> _goToSearchedPlaceLocation() async {
    final GoogleMapController controller = await mapController.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_goToSearchedForPlace));
  }

  Completer<GoogleMapController> mapController = Completer();
  static Position? _position;
  static final CameraPosition _myCurrrentPositionCameraPosition =
      CameraPosition(
          bearing: 0,
          target: LatLng(_position!.latitude, _position!.longitude),
          tilt: 0.0,
          zoom: 17);

//!
  Set<Marker> _markers = {};
  late String? _placeSuggestion;
  late PlaceLocationModel _selectedPlace;
  late Marker _searchedPlaceMarker;
  late CameraPosition _goToSearchedForPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _position != null ? _buildMap() : _buildLoadingIndicator(),
            _buildSelectedPlaceLocation(),
            _isSearchedPlaceMarkerClicked && _placeDirections != null
                ? DistanceAndTime(
                    isTimeAndDistanceVisible: _isTimeAndDistanceVisible,
                    placeDirections: _placeDirections)
                : Container(),
            _buildPlaceDiretions(),
            const MyFloatingSearchBar(),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _markers.isNotEmpty
                ? FloatingActionButton(
                    splashColor: ColorManager.white.withOpacity(0.3),
                    backgroundColor: ColorManager.green,
                    heroTag: 2,
                    onPressed: _goToSearchedPlaceLocation,
                    child: const Icon(
                      Icons.location_searching_outlined,
                      color: ColorManager.white,
                    ),
                  )
                : const SizedBox(),
            Gap(14.h),
            FloatingActionButton(
              splashColor: ColorManager.white.withOpacity(0.3),
              backgroundColor: ColorManager.green,
              heroTag: 1,
              onPressed: _goToMyCurrentLocation,
              child: const Icon(
                Icons.zoom_in_map_rounded,
                color: ColorManager.white,
              ),
            ),
          ],
        ));
  }

  void _buildCameraNewPosition() {
    _isSearchedPlaceMarkerClicked = false;
    log("${_selectedPlace.lat}  ${_selectedPlace.lng}");
    _goToSearchedForPlace = CameraPosition(
      bearing: 0.0,
      tilt: 0.0,
      target: LatLng(
        _selectedPlace.lat,
        _selectedPlace.lng,
      ),
      zoom: 13,
    );
    setState(() {});
  }

  Widget _buildMap() {
    return GoogleMap(
      mapToolbarEnabled: false,
      compassEnabled: true,
      buildingsEnabled: true,
      markers: _markers,
      initialCameraPosition: CameraPosition(
        target: LatLng(_position!.latitude, _position!.longitude),
        zoom: 15.0,
      ),
      circles: {
        Circle(
          circleId: const CircleId("current_location"),
          center: LatLng(_position!.latitude, _position!.longitude),
          radius: 70.r,
          fillColor: ColorManager.lightBlue.withOpacity(0.3),
          strokeColor: ColorManager.lightBlue.withOpacity(0.7),
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
      polylines: _placeDirections != null
          ? {
              Polyline(
                geodesic: true,
                startCap: Cap.roundCap,
                endCap: Cap.roundCap,
                jointType: JointType.round,
                polylineId: const PolylineId('polyline'),
                color: ColorManager.error,
                width: 5,
                points: _polylinePoints,
              ),
            }
          : {},
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    LocationHelper.determineCurrentPosition();
    Geolocator.getCurrentPosition();
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrrentPositionCameraPosition));
  }

  Widget _buildSelectedPlaceLocation() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is MapsLoadedLocationSuccess) {
          _selectedPlace = state.placeLocation[0];
          _placeDirections = null;
          setState(() {});
          _placeSuggestion = state.placeLocation[1];
          log(_selectedPlace.toString());
          _goToMySearchedForLocation();
        }
      },
      child: Container(),
    );
  }

  Future<void> _goToMySearchedForLocation() async {
    _buildCameraNewPosition();
    final GoogleMapController controller = await mapController.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_goToSearchedForPlace));
    _buildSearchedPlaceMarker();
  }

  void _buildSearchedPlaceMarker() {
    _searchedPlaceMarker = Marker(
      position: _goToSearchedForPlace.target,
      markerId: const MarkerId('1'),
      onTap: () {
        _isSearchedPlaceMarkerClicked = true;
        _isTimeAndDistanceVisible = true;
        _getDirections();
        setState(() {});
      },
      infoWindow: InfoWindow(title: _placeSuggestion),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    _addMarkerToMarkersAndUpdateUI(_searchedPlaceMarker);
  }

  void _addMarkerToMarkersAndUpdateUI(Marker marker) {
    _markers = {};
    setState(() {
      _markers.add(marker);
    });
  }

  PlaceDirectionsModel? _placeDirections;

  late List<LatLng> _polylinePoints;
  bool _isSearchedPlaceMarkerClicked = false;
  bool _isTimeAndDistanceVisible = false;

  Widget _buildPlaceDiretions() {
    _placeDirections = null;
    setState(() {});
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is MapsLoadedDirectionsSuccess) {
          _placeDirections = state.placeDirections;
          _getPolylinePoints();
        }
      },
      child: Container(),
    );
  }

  void _getPolylinePoints() {
    _polylinePoints = [];
    _polylinePoints = _placeDirections!.polylinePoints
        .map((polyline) => LatLng(polyline.latitude, polyline.longitude))
        .toList();
  }

  /// call
  Future<void> _getDirections() async {
    await context.bloc<MapsCubit>().getPlaceDirections(
          origin: LatLng(_position!.latitude, _position!.longitude),
          destination: LatLng(_selectedPlace.lat, _selectedPlace.lng),
        );
    setState(() {});
  }

  Widget _buildLoadingIndicator() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: ColorManager.green.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: SizedBox(
          width: 25.w,
          height: 25.w,
          child: const CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }
}
