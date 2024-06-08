# Dr. AI - Your Medical Assistant

Dr. AI is an advanced, Flutter-based mobile application developed to act as your personal medical assistant. It combines state-of-the-art technology with medical expertise to provide users with a comprehensive healthcare companion right on their smartphones. The application offers a range of features designed to make healthcare information and services easily accessible, ensuring users can manage their medical needs effectively and promptly.

## Key Capabilities

`Medical Queries:` Users can ask medical questions and receive accurate, timely responses. This feature is powered by a robust backend that sources information from reliable medical databases and expert systems, ensuring the advice and information provided are trustworthy and up-to-date.

`Medicine Information:` The app allows users to search for detailed information about various medicines, including their uses, side effects, dosage recommendations, and more. This feature is designed to help users make informed decisions about their medications.

`Hospital Locator:` In case of emergencies, users can leverage the integrated Google Maps functionality to search for hospitals. The app provides real-time data on the nearest hospitals, helping users navigate quickly to the closest medical facility when every second counts.

`Medical History Access:` Dr. AI securely stores users' medical histories in Firebase, allowing users to access their records at any time. This is particularly useful during emergencies, where having quick access to medical history can be crucial. Users can also share their medical history with healthcare providers through NFC technology.

`Emergency Support:` The application features an emergency support system that allows users to initiate a chat with a medical assistant or call emergency services directly from the app. This ensures that users can get immediate help in critical situations.

`Data Privacy and Control:` Users have full control over their personal data. The app includes options to show or hide specific information, ensuring that users can manage their privacy preferences according to their comfort level. All data is securely stored in Firebase, adhering to best practices in data security and privacy.

## Technical Stack

`Frontend:` Developed using Flutter, the app boasts a responsive and intuitive user interface that works seamlessly across both Android and iOS platforms.
`Backend:` Firebase serves as the backbone for data storage, authentication, and real-time database management, ensuring reliable and secure data handling.
`APIs and Integrations:` The app integrates various third-party APIs such as ChatGPT 4 for medical assistant, Google Maps for location services, and NFC technology for sharing medical data.

## Why Choose Dr. AI?

Dr. AI is designed to be more than just a medical app; it's a comprehensive health assistant that combines the power of modern technology with essential healthcare services. Whether it's a routine checkup or an emergency, Dr. AI is equipped to provide users with the necessary tools and information to manage their health proactively and effectively. With features like real-time hospital navigation, instant medical queries, and secure medical history access, Dr. AI stands out as a reliable companion in the digital health landscape.

## Installation

To run Dr. AI on your local machine, follow these steps:

1. Clone this repository.
2. Ensure you have Flutter installed. If not, follow the official Flutter installation guide [here](https://flutter.dev/docs/get-started/install).
3. Open the project in your preferred IDE or code editor.
4. Run the following command to get the required dependencies:
5. Launch the application on an emulator or connected device using:


## Dependencies

Dr. AI uses various packages to provide its functionality, including but not limited to:
```
dependencies:
  animated_bottom_navigation_bar: ^1.3.0
  bloc: ^8.1.2
  cached_network_image: ^3.3.1
  cloud_firestore: ^4.13.3
  cupertino_icons: ^1.0.2
  dio: ^5.4.0
  dropdown_button2: ^2.3.9
  easy_stepper: ^0.8.3
  firebase_auth: ^4.15.0
  firebase_core: ^2.24.0
  firebase_storage: ^11.7.2
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  flutter_dotenv: ^5.1.0
  flutter_facebook_auth: ^6.2.0
  flutter_polyline_points: ^2.0.0
  flutter_screenutil: ^5.9.0
  flutter_svg: ^2.0.10+1
  gap: ^3.0.1
  geolocator: ^11.0.0
  google_fonts: ^6.1.0
  google_maps_flutter: ^2.5.3
  google_sign_in: ^6.1.6
  image_picker: ^1.0.4
  intl: ^0.19.0
  loading_indicator: ^3.1.1
  location: ^6.0.1
  lottie: ^2.4.0
  material_floating_search_bar_2: ^0.5.0
  meta: ^1.10.0
  modal_progress_hud_nsn: ^0.5.1
  shared_preferences: ^2.2.2
  sign_in_with_apple: ^6.1.0
  url_launcher: ^6.2.4
  uuid: ^4.3.3

dev_dependencies:
  flutter_launcher_icons: "^0.13.1"
  flutter_lints: ^2.0.0
  flutter_test:
    sdk: flutter
```
For a complete list of dependencies, refer to the `pubspec.yaml` file.

## Firebase Configuration

Add Firebase to your project: Follow the Firebase documentation to add Firebase to your Flutter project.
Initialize Firebase: Initialize Firebase in your `main.dart` file.
dart
```
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

## Assets
Ensure the following assets are added to your project in the pubspec.yaml file:
```
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/animations/
    - .env
  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Medium.ttf
          weight: 500
        - asset: assets/fonts/Poppins-Regular.ttf
          weight: 400
        - asset: assets/fonts/Poppins-SemiBold.ttf
          weight: 600
```
## License
This project is licensed under the [MIT License] - see the LICENSE file for details.

## Support

For any inquiries or support regarding Dr. AI, you can reach out to [gcfjxvkj@gmail.com] - [mohammedhafiez.h@gmail.com].

---

Thank you for using Dr. AI! We hope this application helps you in your medical queries and makes healthcare more accessible and convenient.
