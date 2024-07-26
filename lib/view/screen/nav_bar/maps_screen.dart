import 'dart:async';
import 'dart:developer';
import 'package:dr_ai/utils/constant/color.dart';
import 'package:dr_ai/utils/helper/extention.dart';
import 'package:dr_ai/utils/helper/location.dart';
import 'package:dr_ai/data/model/place_directions.dart';
import 'package:dr_ai/data/model/place_location.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
import 'package:dr_ai/view/widget/button_loading_indicator.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_tooltip.dart';
import 'package:dr_ai/view/widget/directions_details_card.dart';
import 'package:dr_ai/view/widget/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../utils/helper/scaffold_snakbar.dart';
import '../../../data/model/find_hospital_place_info.dart';
import '../../../logic/maps/maps_cubit.dart';
// Empty commit

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _getCurrentLocation();

    // _loadCachedHospitals();
  }

  late GlobalKey<ScaffoldState> _scaffoldKey;

  Future<void> _getCurrentLocation() async {
    await LocationHelper.determineCurrentPosition(context);
    _position = await Geolocator.getCurrentPosition().whenComplete(() async {
      setState(() {});
    });
  }

  Future<void> _goToSearchedPlaceLocation() async {
    final GoogleMapController mapController = await completerController.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0.0,
          tilt: 0.0,
          target: LatLng(
            _selectedPlace.lat,
            _selectedPlace.lng,
          ),
          zoom: 17,
        ),
      ),
    );
  }

  Completer<GoogleMapController> completerController = Completer();
  static Position? _position;
  static final CameraPosition _myCurrrentPositionCameraPosition =
      CameraPosition(
          bearing: 0,
          target: LatLng(_position!.latitude, _position!.longitude),
          tilt: 0.0,
          zoom: 17);

  Set<Marker> _markers = {};
  late String? _placeSuggestion;
  late PlaceLocationModel _selectedPlace;
  late Marker _searchedPlaceMarker;
  late CameraPosition _goToSearchedForPlace;
  // Future<void> _loadCachedHospitals() async {
  //   List<Map<String, dynamic>> cachedData =
  //       CacheData.getListOfMaps(key: 'nearestHospitals');
  //   if (cachedData.isNotEmpty) {
  //     setState(() {
  //       _cachedHospitalList = cachedData;
  //       _addMarkersFromCachedHospitals();
  //     });
  //   }
  // }

  bool _isLoading = false;
  List<FindHospitalsPlaceInfo?> _hospitalList = [];
  // List<Map<String, dynamic>> _cachedHospitalList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawerScrimColor: ColorManager.black.withOpacity(0.4),
        drawer: _buildDrawer(),
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
            _buildPlaceDirections(),
            const MyFloatingSearchBar(),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isTimeAndDistanceVisible)
              CustomToolTip(
                bottomMargin: 20,
                message: "Searched Location",
                child: FloatingActionButton.small(
                  splashColor: ColorManager.white.withOpacity(0.3),
                  backgroundColor: ColorManager.green,
                  heroTag: 2,
                  onPressed: () {
                    _goToSearchedPlaceLocation();
                  },
                  child: const Icon(
                    Icons.location_searching_outlined,
                    color: ColorManager.white,
                  ),
                ),
              )
            else
              const SizedBox(),
            Gap(10.h),
            CustomToolTip(
              bottomMargin: 20,
              message: "Current Location",
              child: FloatingActionButton(
                splashColor: ColorManager.white.withOpacity(0.3),
                backgroundColor: ColorManager.green,
                heroTag: 3,
                onPressed: _goToMyCurrentLocation,
                child: const Icon(
                  Icons.zoom_in_map_rounded,
                  color: ColorManager.white,
                ),
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
      zoom: 17,
    );
    setState(() {});
  }

  Widget _buildMap() {
    return GoogleMap(
      mapToolbarEnabled: false,
      // trafficEnabled: true,
      compassEnabled: true,
      buildingsEnabled: true,
      markers: _markers.isEmpty
          ? {
              // Marker(
              //   markerId: const MarkerId('currentLocation'),
              //   position: LatLng(_position!.latitude, _position!.longitude),
              //   icon: BitmapDescriptor.defaultMarkerWithHue(
              //       BitmapDescriptor.hueGreen),
              //   infoWindow: const InfoWindow(
              //     title: 'Current Location',
              //     snippet: 'This is your current location',
              //   ),
              // ),
            }
          : _markers,
      initialCameraPosition: CameraPosition(
        target: LatLng(_position!.latitude, _position!.longitude),
        zoom: 15.0,
      ),
      circles: {
        Circle(
          circleId: const CircleId("current_location"),
          center: LatLng(_position!.latitude, _position!.longitude),
          radius: 70.r,
          fillColor: ColorManager.green.withOpacity(0.25),
          strokeColor: ColorManager.green.withOpacity(0.7),
          strokeWidth: 1,
        ),
      },
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        completerController.complete(controller);
      },
      polylines: _placeDirections != null
          ? {
              Polyline(
                geodesic: true,
                startCap: Cap.roundCap,
                endCap: Cap.roundCap,
                jointType: JointType.round,
                polylineId: const PolylineId('polyline'),
                color: ColorManager.green,
                width: 5,
                points: _polylinePoints,
              ),
            }
          : {},
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    LocationHelper.determineCurrentPosition(context);
    Geolocator.getCurrentPosition();
    final GoogleMapController controller = await completerController.future;
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
    final GoogleMapController controller = await completerController.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_goToSearchedForPlace));
    _buildSearchedPlaceMarker();
  }

  void _buildSearchedPlaceMarker() {
    String randomMarkerId = const Uuid().v4();
    _searchedPlaceMarker = Marker(
      position: _goToSearchedForPlace.target,
      markerId: MarkerId(randomMarkerId),
      onTap: () {
        _isSearchedPlaceMarkerClicked = true;
        _isTimeAndDistanceVisible = true;
        _getDirections();
        setState(() {});
      },
      infoWindow: InfoWindow(title: _placeSuggestion),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    _addMarkerToMarkersAndUpdateUI(_searchedPlaceMarker);
  }

  void _addMarkerToMarkersAndUpdateUI(Marker marker) {
    _markers = {};
    setState(() {
      _markers.add(marker);
    });
  }

  void _addMarkersFromHospitalList() {
    _markers = {};
    for (var hospital in _hospitalList) {
      final marker = Marker(
        markerId: MarkerId(hospital!.placeId),
        position: LatLng(hospital.lat, hospital.lng),
        infoWindow: InfoWindow(title: hospital.name),
        onTap: () {
          _selectedPlace =
              PlaceLocationModel(lat: hospital.lat, lng: hospital.lng);
          _isSearchedPlaceMarkerClicked = true;
          _isTimeAndDistanceVisible = true;
          _getDirections();
          setState(() {});
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
      _markers.add(marker);
    }
    setState(() {});
  }

  // void _addMarkersFromCachedHospitals() {
  //   _markers = {};
  //   for (var hospital in _cachedHospitalList) {
  //     final marker = Marker(
  //       markerId: MarkerId(hospital['placeId']),
  //       position: LatLng(hospital['lat'], hospital['lng']),
  //       infoWindow: InfoWindow(title: hospital['name']),
  //       onTap: () {
  //         _selectedPlace =
  //             PlaceLocationModel(lat: hospital['lat'], lng: hospital['lng']);
  //         _isSearchedPlaceMarkerClicked = true;
  //         _isTimeAndDistanceVisible = true;
  //         _getDirections();
  //         setState(() {});
  //       },
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //     );
  //     _markers.add(marker);
  //   }
  //   setState(() {});
  // }

  PlaceDirectionsModel? _placeDirections;

  late List<LatLng> _polylinePoints;
  bool _isSearchedPlaceMarkerClicked = false;
  bool _isTimeAndDistanceVisible = false;

  Widget _buildPlaceDirections() {
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
        decoration: const BoxDecoration(
          color: ColorManager.green,
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

  void _markNearestHospital() {
    if (_hospitalList.isEmpty
        // && _cachedHospitalList.isEmpty
        ) return;

    double nearestDistance = double.infinity;
    FindHospitalsPlaceInfo? nearestHospital;
    LatLng currentPosition = LatLng(_position!.latitude, _position!.longitude);

    for (var hospital in _hospitalList) {
      LatLng hospitalPosition = LatLng(hospital!.lat, hospital.lng);
      double distance = Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        hospitalPosition.latitude,
        hospitalPosition.longitude,
      );

      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearestHospital = hospital;
      }
    }

    // for (var hospital in _cachedHospitalList) {
    //   LatLng hospitalPosition = LatLng(hospital['lat'], hospital['lng']);
    //   double distance = Geolocator.distanceBetween(
    //     currentPosition.latitude,
    //     currentPosition.longitude,
    //     hospitalPosition.latitude,
    //     hospitalPosition.longitude,
    //   );

    //   if (distance < nearestDistance) {
    //     nearestDistance = distance;
    //     nearestHospital = PlaceInfo(
    //       placeId: hospital['placeId'],
    //       lat: hospital['lat'],
    //       lng: hospital['lng'],
    //       name: hospital['name'],
    //       openNow: hospital['openNow'],
    //     );
    //   }
    // }

    _markers = {};
    for (var hospital in _hospitalList) {
      final marker = Marker(
        markerId: MarkerId(hospital!.placeId),
        position: LatLng(hospital.lat, hospital.lng),
        infoWindow: InfoWindow(title: hospital.name),
        onTap: () {
          _selectedPlace =
              PlaceLocationModel(lat: hospital.lat, lng: hospital.lng);
          _isSearchedPlaceMarkerClicked = true;
          _isTimeAndDistanceVisible = true;
          _getDirections();
          setState(() {});
        },
        icon: nearestHospital != null &&
                hospital.placeId == nearestHospital.placeId
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
      _markers.add(marker);
    }
  }

  Widget _buildDrawer() {
    return BlocConsumer<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is FindHospitalLoading) {
          _isLoading = true;
        } else if (state is FindHospitalSuccess) {
          _isLoading = false;
          _hospitalList = state.hospitalsList;
          _addMarkersFromHospitalList();
          _markNearestHospital();
        } else if (state is FindHospitalFailure) {
          _isLoading = false;

          customSnackBar(
              context, 'There was an error! Please try again later.');
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1400),
            height: _hospitalList.isEmpty || _hospitalList.length <= 3
                ? context.height / 2
                : context.height,
            child: Drawer(
              backgroundColor: ColorManager.trasnsparent.withOpacity(0.2),
              width: context.width / 1.3,
              child: Column(
                children: [
                  _buildTotalHospital(
                      _hospitalList.isNotEmpty ? _hospitalList.length : 0
                      // : _cachedHospitalList.length
                      ),
                  Gap(2.h),
                  (_hospitalList.isNotEmpty)
                      ? Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: _hospitalList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 2,
                                color: ColorManager.white,
                                child: ListTile(
                                  onTap: () {
                                    _selectedPlace = PlaceLocationModel(
                                      lat: _hospitalList[index]!.lat,
                                      lng: _hospitalList[index]!.lng,
                                    );
                                    _buildCameraNewPosition();
                                    _goToSearchedPlaceLocation();
                                    _markNearestHospital();
                                    _getDirections();
                                    _isTimeAndDistanceVisible = true;
                                    _isSearchedPlaceMarkerClicked = true;
                                    setState(() {});
                                    _scaffoldKey.currentState?.closeDrawer();
                                  },
                                  title: Text(
                                    _hospitalList[index]?.name ?? '',
                                    textAlign: TextAlign.center,
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: ColorManager.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: (_hospitalList[index]!
                                          .internationalPhoneNumber!
                                          .isNotEmpty)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${_hospitalList[index]?.internationalPhoneNumber}",
                                              style: context.textTheme.bodySmall
                                                  ?.copyWith(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  context
                                                      .bloc<ValidationCubit>()
                                                      .copyText(_hospitalList[
                                                              index]
                                                          ?.internationalPhoneNumber);
                                                  customSnackBar(
                                                      context,
                                                      "Text copied to clipboard",
                                                      null,
                                                      1);
                                                },
                                                icon: Icon(
                                                  Icons.content_copy,
                                                  size: 17.r,
                                                ))
                                          ],
                                        )
                                      : null,
                                  trailing: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "rating",
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontSize: 12.spMin,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        (_hospitalList[index]?.rating)
                                            .toString(),
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                                color: _hospitalList[index]!
                                                            .rating! >=
                                                        2.5
                                                    ? ColorManager.correct
                                                    : ColorManager.error),
                                      )
                                    ],
                                  ),
                                  leading: _hospitalList[index]!.openNow!
                                      ? const Icon(
                                          Icons.lock_open,
                                          color: ColorManager.correct,
                                        )
                                      : const Icon(
                                          Icons.lock_outline,
                                          color: ColorManager.error,
                                        ),
                                ),
                              );
                            },
                          ),
                        )
                      // : _cachedHospitalList.isNotEmpty
                      //     ? Expanded(
                      //         child: ListView.builder(
                      //           itemCount: _cachedHospitalList.length,
                      //           itemBuilder: (context, index) {
                      //             final hospital =
                      //                 _cachedHospitalList[index];
                      //             return Card(
                      //               child: ListTile(
                      //                 onTap: () {
                      //                   _selectedPlace =
                      //                       PlaceLocationModel(
                      //                     lat: hospital['lat'],
                      //                     lng: hospital['lng'],
                      //                   );
                      //                   _buildCameraNewPosition();
                      //                   _goToSearchedPlaceLocation();
                      //                   _markNearestHospital();
                      //                 },
                      //                 title: Text(hospital['name'],
                      //                     style: context
                      //                         .textTheme.bodyMedium),
                      //                 subtitle: Row(
                      //                   children: [
                      //                     Text(
                      //                       (hospital['openNow'])
                      //                           .toString(),
                      //                       style: context
                      //                           .textTheme.bodyMedium
                      //                           ?.copyWith(
                      //                               color: Colors.green),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 trailing:
                      //                     const Icon(Icons.chevron_right),
                      //                 leading: const Icon(Icons.healing),
                      //               ),
                      //             );
                      //           },
                      //         ),
                      //       )
                      //     : Expanded(
                      //         child: Icon(
                      //           Icons.find_replace_rounded,
                      //           size: 100.sp,
                      //           color:
                      //               context.appBarTheme.backgroundColor,
                      //         ),
                      //       ),

                      : const Expanded(
                          child: Icon(
                            Icons.my_location_rounded,
                            color: ColorManager.green,
                            size: 60,
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: CustomButton(
                      isDisabled: _isLoading,
                      size: Size(context.width * 0.475, 38.w),
                      onPressed: () {
                        context.bloc<MapsCubit>().getNearestHospitals();
                      },
                      title: "Find Hospitals",
                      widget:
                          _isLoading ? const ButtonLoadingIndicator() : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalHospital(int totalHospital) {
    return Card(
      margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h, bottom: 2.h),
      color: ColorManager.green,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Hospitals Founded:  ",
                    style: context.textTheme.displayMedium?.copyWith(
                        fontSize: 14.spMin, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    totalHospital.toString(),
                    style: context.textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
