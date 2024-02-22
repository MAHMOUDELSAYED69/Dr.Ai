class PlaceSuggestionModel {
  String description;
  String placeId;
  String mainText;
  String secondaryText;

  PlaceSuggestionModel({
    required this.description,
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
  });

  factory PlaceSuggestionModel.fromJson(Map<String, dynamic> json) {
    final structuredFormatting = json['structured_formatting'];
    return PlaceSuggestionModel(
      description: json['description'],
      placeId: json['place_id'],
      mainText: structuredFormatting['main_text'],
      secondaryText: structuredFormatting['secondary_text'],
    );
  }
}