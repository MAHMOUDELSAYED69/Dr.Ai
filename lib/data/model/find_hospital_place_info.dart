
class FindHospitalsPlaceInfo {
  final String? businessStatus;
  final double lat;
  final double lng;
  final double? northeastLat;
  final double? northeastLng;
  final double? southwestLat;
  final double? southwestLng;
  final String? icon;
  final String? iconBackgroundColor;
  final String? iconMaskBaseUri;
  final String name;
  final String placeId;
  final String? compoundCode;
  final String? globalCode;
  final String? reference;
  final String? scope;
  final List<String>? types;
  final String? vicinity;
  final bool? openNow;
  final List<Map<String, dynamic>>? photos;
  final double? rating;
  final int? userRatingsTotal;
  final String? formattedPhoneNumber;
  final String? internationalPhoneNumber;
  final String? website;
  final List<Map<String, dynamic>>? addressComponents;
  final String? formattedAddress;
  final int? utcOffset;
  final String? url;
  final String? adrAddress;
  final String? distance; // New field for distance
  final String? duration; // New field for duration

  FindHospitalsPlaceInfo({
    this.businessStatus,
    required this.lat,
    required this.lng,
    this.northeastLat,
    this.northeastLng,
    this.southwestLat,
    this.southwestLng,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    required this.name,
    required this.placeId,
    this.compoundCode,
    this.globalCode,
    this.reference,
    this.scope,
    this.types,
    this.vicinity,
    this.openNow,
    this.photos,
    this.rating,
    this.userRatingsTotal,
    this.formattedPhoneNumber,
    this.internationalPhoneNumber,
    this.website,
    this.addressComponents,
    this.formattedAddress,
    this.utcOffset,
    this.url,
    this.adrAddress,
    this.distance, // Initialize new field
    this.duration, // Initialize new field
  });

  factory FindHospitalsPlaceInfo.fromJson(Map<String, dynamic> json) {
    var geometry = json['geometry'] ?? {};
    var location = geometry['location'] ?? {};
    var viewport = geometry['viewport'] ?? {};
    var northeast = viewport['northeast'] ?? {};
    var southwest = viewport['southwest'] ?? {};
    var openingHours = json['opening_hours'] ?? {};
    var photoList = json['photos'] as List? ?? [];
    var plusCode = json['plus_code'] ?? {};
    var addressComponentsList = json['address_components'] as List? ?? [];

    return FindHospitalsPlaceInfo(
      businessStatus: json['business_status'] ?? 'UNKNOWN',
      lat: location['lat'] ?? 0.0,
      lng: location['lng'] ?? 0.0,
      northeastLat: northeast['lat'] ?? 0.0,
      northeastLng: northeast['lng'] ?? 0.0,
      southwestLat: southwest['lat'] ?? 0.0,
      southwestLng: southwest['lng'] ?? 0.0,
      icon: json['icon'] ?? '',
      iconBackgroundColor: json['icon_background_color'] ?? '',
      iconMaskBaseUri: json['icon_mask_base_uri'] ?? '',
      name: json['name'] ?? '',
      placeId: json['place_id'] ?? '',
      compoundCode: plusCode['compound_code'] ?? '',
      globalCode: plusCode['global_code'] ?? '',
      reference: json['reference'] ?? '',
      scope: json['scope'] ?? '',
      types: List<String>.from(json['types'] ?? []),
      vicinity: json['vicinity'] ?? '',
      openNow: openingHours['open_now'] ?? false,
      photos: photoList
          .map((photo) => {
                'height': photo['height'] ?? 0,
                'html_attributions':
                    List<String>.from(photo['html_attributions'] ?? []),
                'photo_reference': photo['photo_reference'] ?? '',
                'width': photo['width'] ?? 0,
              })
          .toList() as List<Map<String, dynamic>>?,
      rating: (json['rating'] ?? 0.0).toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
      formattedPhoneNumber: json['formatted_phone_number'] ?? '',
      internationalPhoneNumber: json['international_phone_number'] ?? '',
      website: json['website'] ?? '',
      addressComponents: addressComponentsList
          .map((component) => {
                'long_name': component['long_name'] ?? '',
                'short_name': component['short_name'] ?? '',
                'types': List<String>.from(component['types'] ?? []),
              })
          .toList(),
      formattedAddress: json['formatted_address'] ?? '',
      utcOffset: json['utc_offset'] ?? 0,
      url: json['url'] ?? '',
      adrAddress: json['adr_address'] ?? '',
      distance: json['distance'] ?? '', // Parse new field
      duration: json['duration'] ?? '', // Parse new field
    );
  }
}
