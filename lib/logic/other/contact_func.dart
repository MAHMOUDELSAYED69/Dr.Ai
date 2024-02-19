// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

class OtherMethod {
  // static openContactsApp({required String phoneNumber}) async {
  //   final url = 'tel:$phoneNumber';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  static Future<void> openContactsApp({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
