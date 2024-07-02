# Dr. AI - Your Medical Assistant

Dr. AI is an advanced, Flutter-based mobile application developed to act as your personal medical assistant. It combines state-of-the-art technology with medical expertise to provide users with a comprehensive healthcare companion right on their smartphones. The application offers a range of features designed to make healthcare information and services easily accessible, ensuring users can manage their medical needs effectively and promptly.

## Key Capabilities

`Medical Queries:` Users can ask medical questions and receive accurate, timely responses. This feature is powered by a robust backend that sources information from reliable medical databases and expert systems, ensuring the advice and information provided are trustworthy and up-to-date.

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

To get started with the Dr. AI mobile application, follow these steps:

`Step 1:` Clone the Repository
First, you'll need to clone the repository from GitHub. Open your terminal and run the following command:
```
git clone https://github.com/MAHMOUDELSAYED69/DR-AI.git
```
Replace <repository-url> with the actual URL of your repository if it was changed.

`Step 2:` Install Dependencies
After navigating to the project directory, you need to install all the necessary dependencies. Run:
```
flutter pub get
```
This command fetches all the dependencies listed in the `pubspec.yaml` file.

`Step 3:` Set Up Firebase
Dr. AI uses Firebase for authentication, data storage, and other backend services. Follow these steps to set up Firebase:

Add `Firebase` to Your Project:

Go to the `Firebase Console`.

Create a new project or select an existing one.
Add an Android and iOS app to your Firebase project.

Download Configuration Files:

For `Android:` Download the google-services.json file and place it in the android/app directory.

For `iOS:` Download the GoogleService-Info.plist file and add it to the ios/Runner directory.

Initialize Firebase in Your Project:

Open main.dart and initialize Firebase by adding the following code:

```
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

`Step 4:` Configure the App
Ensure all necessary configurations are done. This includes adding your assets and setting up environment variables if needed. Verify that your `pubspec.yaml` file includes all required `assets` and `fonts`.

`Step 5:` Run the Application
Finally, run the application on your desired device using the following command:
`
```
flutter run
```
This command compiles your Flutter app and deploys it to the connected device or simulator.

Additional Tips
`Updating Dependencies:` If there are any updates to the dependencies, you can update them using:
```
flutter pub upgrade --major-versions
```
Flutter Doctor: Run flutter doctor to ensure that your development environment is set up correctly.
```
flutter doctor
```
This command checks your environment and displays a report of the status of your Flutter installation, dependencies, and connected devices.

By following these steps, you'll have the Dr. AI app up and running on your device, ready to serve as your personal medical assistant. If you encounter any issues during installation, please refer to the Flutter documentation or the Firebase setup guide for additional help.

## Dependencies

Dr. AI uses various packages to provide its functionality, including but not limited to:

dependencies:

  `animated_bottom_navigation_bar:` A package for creating animated bottom navigation bars with customizable animations.
  
  `bloc:` The core library for the BLoC (Business Logic Component) pattern, which helps manage state in Flutter apps.
  
  `cached_network_image:` Provides a widget to display images from the network with caching functionality.
  
  `cloud_firestore:` The Flutter plugin for Cloud Firestore, a NoSQL database provided by Firebase.
  
  `cupertino_icons:` A set of iOS-style icons for use in Flutter applications.
  
  `dio:` A powerful HTTP client for Dart, which supports interceptors, global configuration, and more.
  
  `dropdown_button2:` An enhanced DropdownButton widget with more customization options.
  
  `easy_stepper:` A package for creating stepper widgets with customizable steps and animations.
  
  `firebase_auth:` The Flutter plugin for Firebase Authentication, which supports various authentication methods.
  
  `firebase_core:` The Flutter plugin for Firebase Core, required for initializing Firebase services.
  
  `firebase_storage:` The Flutter plugin for Firebase Cloud Storage, allowing file uploads and downloads.
  
  `flutter:`
    `sdk: flutter` The Flutter SDK itself.
  
  `flutter_bloc:` A Flutter package that integrates the bloc state management library with Flutter.
  
  `flutter_dotenv:` A library for loading environment variables from a .env file.
  
  `flutter_facebook_auth:` A package for integrating Facebook authentication in Flutter apps.
  
  `flutter_polyline_points:` A package to decode encoded polylines and use them with Google Maps in Flutter.
  
  `flutter_screenutil:` A utility for adapting screen and font size based on device dimensions.
  
  `flutter_svg:` A package for rendering SVG (Scalable Vector Graphics) in Flutter.
  
  `gap:` A simple package for adding vertical and horizontal gaps (spacers) between widgets.
  
  `geolocator:` A Flutter geolocation plugin for accessing device location.
  
  `google_fonts:` A package to easily use fonts from Google Fonts in Flutter apps.
  
  `google_maps_flutter:` The official Google Maps plugin for Flutter.
  
  `google_sign_in:` A Flutter plugin for Google Sign-In.
  
  `image_picker:` A package for picking images from the device gallery or camera.
  
  `intl:` A package for internationalization and localization, including date and number formatting.
  
  `loading_indicator:` A collection of animated loading indicators.
  
  `location:` A plugin to get the location of the device, including latitude and longitude.
  
  `lottie:` A package for displaying animations created in Adobe After Effects using the Lottie library.
  
  `material_floating_search_bar_2:` A floating search bar library for Flutter with a Material Design style.
  
  `meta:` A package that provides annotations for improved code analysis.
  
  `modal_progress_hud_nsn:` A package for showing a modal progress indicator (HUD) while an asynchronous task is running.
  
  `shared_preferences:` A Flutter plugin for storing simple data (key-value pairs) locally.
  
  `sign_in_with_apple:` A package for integrating Sign in with Apple in Flutter apps.
  
  `url_launcher:` A plugin for launching URLs in the mobile platform.
  
  `uuid:` A package for generating UUIDs (Universally Unique Identifiers).

dev_dependencies:
  
  `flutter_launcher_icons:` A package to help with creating app launcher icons.
  
  `flutter_lints:` A package that provides recommended lints for Flutter projects.
  
  `flutter_test:`
   ` sdk: flutter` The Flutter testing framework.

For a complete list of dependencies, refer to the `pubspec.yaml` file.

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
