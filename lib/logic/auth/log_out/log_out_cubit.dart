import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../core/cache/cache.dart';
import '../../../data/service/firebase/firebase_service.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());

  Future<void> logOut() async {
    emit(LogOutLoading());
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('log_out').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        dynamic permission = documentSnapshot.data()['permission'];
        
        if (permission == true) {
          await FirebaseService.logOut();
          await CacheData.clearData(clearData: true);
          emit(LogOutSuccess());
        }
      }
    } on FirebaseAuthException catch (err) {
      emit(LogOutFailure(message: err.code));
    } catch (err) {
      emit(LogOutFailure(message: err.toString()));
    }
  }
}
