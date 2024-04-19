class UserDataModel {
  String email;
  String uid;
  String name;
  String phoneNumber;
  String dob;
  String gender;
  String bloodType;
  String height;
  String weight;
  String chronicDiseases;
  String familyHistoryOfChronicDiseases;

  UserDataModel({
    required this.email,
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.dob,
    required this.gender,
    required this.bloodType,
    required this.height,
    required this.weight,
    required this.chronicDiseases,
    required this.familyHistoryOfChronicDiseases,
  });

  UserDataModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        uid = json['uid'],
        name = json['name'],
        phoneNumber = json['phoneNumber'],
        dob = json['dob'],
        gender = json['gender'],
        bloodType = json['bloodType'],
        height = json['height'],
        weight = json['weight'],
        chronicDiseases = json['chronicDiseases'],
        familyHistoryOfChronicDiseases = json['familyHistoryOfChronicDiseases'];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'gender': gender,
      'bloodType': bloodType,
      'height': height,
      'weight': weight,
      'chronicDiseases': chronicDiseases,
      'familyHistoryOfChronicDiseases': familyHistoryOfChronicDiseases,
    };
  }
  
}
