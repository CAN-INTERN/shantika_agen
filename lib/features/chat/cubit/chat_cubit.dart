import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;

  ChatCubit(this._repository) : super(ChatInitial());

  Future<void> fetchChats() async {
    try {
      emit(ChatLoading());
      final response = await _repository.getChats();

      if (response.success && response.data.isNotEmpty) {
        emit(ChatLoaded(response.data));
      } else {
        emit(const ChatError('No chat contacts available'));
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> refreshChats() async {
    await fetchChats();
  }
}