import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/data/model/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  final _firestore = FirebaseFirestore.instance;
  Future<void> getprofileData() async {
    emit(AccountLoading());
    try {
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .snapshots()
          .listen((event) {
        UserDataModel userDataModel = UserDataModel.fromJson(event.data()!);
        log(userDataModel.name.toString());
        emit(AccountSuccess(userDataModel: userDataModel));
      });
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }

  Future<void> logout() async {
    emit(AccountLogoutLoading());
    try {
      await CacheData.clearData(clearData: true);
      await FirebaseAuth.instance.signOut();
      emit(AccountLogoutSuccess(message: "Logout successfully"));
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(AccountDeleteLoading());
    try {
      await CacheData.clearData(clearData: true);
      await FirebaseAuth.instance.currentUser!.delete();
      await FirebaseAuth.instance.signOut();
      emit(AccountDeleteSuccess(
        message: "Account deleted successfully",
      ));
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }
}
