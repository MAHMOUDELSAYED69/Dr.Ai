import 'package:bloc/bloc.dart';
import 'package:dr_ai/logic/auth/login/login_cubit.dart';
import 'package:meta/meta.dart';

import '../../core/cache/cache.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  Future<void> homeUserData() async {
    emit(HomeLoading());
    try {
      var fullNameFire = await CacheData.getdata(key: "fullNameFire");
      var image = await CacheData.getdata(key: "imageFire");
      var cacheImage = await CacheData.getdata(key: "uploadImage");
      emit(HomeSuccess(
          cacheImage: cacheImage,
          firebaseName: fullNameFire,
          image: image));
    } on Exception catch (err) {
      emit(HomeFailure(message: err.toString()));
    }
  }
}
