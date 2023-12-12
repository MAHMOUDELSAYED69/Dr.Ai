import 'package:bloc/bloc.dart';
import 'package:dr_ai/data/model/message_model.dart';
import 'package:meta/meta.dart';

import '../../data/service/get_messae.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<UserMessage?> sendMessage({required String data}) async {
    emit(ChatLoading());
    try {
      final response = await MessageService.postData(data: {'content': data});
      emit(ChatSuccess(response: response.message));

    } on Exception catch (err) {
      emit(ChatFailure(message: err.toString()));
    }
    return null;
  }
}
