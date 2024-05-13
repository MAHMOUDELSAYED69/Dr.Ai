import 'package:bloc/bloc.dart';
import 'package:url_launcher/url_launcher.dart';

enum LaunchUriState {
  launchInitial,
  launchOpen,
  launchFailure,
}

class LaunchUriCubit extends Cubit<LaunchUriState> {
  LaunchUriCubit() : super(LaunchUriState.launchInitial);

  Future<void> openContactsApp(
      {required String phoneNumber, String? scheme}) async {
    try {
      final Uri launchUri = Uri(
        scheme: scheme ?? 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
      emit(LaunchUriState.launchOpen);
    } catch (err) {
      emit(LaunchUriState.launchFailure);
      Future.error(Exception("Failed to open contacts app: $err"));
    }
  }
}
