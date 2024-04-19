import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  final _auth = FirebaseAuth.instance.currentUser!.email;
  final _firestore = FirebaseFirestore.instance;
  Future<void> profileData() async {
    emit(AccountLoading());
    try {
      _firestore.collection('users').doc(_auth).snapshots().listen((event) {});

      emit(AccountSuccess());
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }
}
