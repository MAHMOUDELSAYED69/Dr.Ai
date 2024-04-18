import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'launch_uri_state.dart';

class LaunchUriCubit extends Cubit<LaunchUriState> {
  LaunchUriCubit() : super(LaunchUriInitial());

  Future<void> openContactsApp({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
    emit(LaunchUriOpen());
  }
}
