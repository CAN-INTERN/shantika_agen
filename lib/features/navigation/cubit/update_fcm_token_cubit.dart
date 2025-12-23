import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'update_fcm_token_state.dart';

class UpdateFcmTokenCubit extends Cubit<UpdateFcmTokenState> {
  UpdateFcmTokenCubit() : super(UpdateFcmTokenInitial());

  // late AuthRepository _repository;
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  //
  // init() {
  //   _repository = AuthRepository(serviceLocator.get());
  // }
  //
  // updateFcmToken() async {
  //   String? fcmToken = await messaging.getToken();
  //   emit(UpdateFcmTokenStateLoading());
  //
  //   DataState<ApiResponse> dataState = await _repository.updateFcmToken(fcmToken: fcmToken ?? "");
  //
  //   switch (dataState) {
  //     case DataStateSuccess<ApiResponse>():
  //       {
  //         emit(UpdateFcmTokenStateSuccess());
  //       }
  //     case DataStateError<ApiResponse>():
  //       {
  //         emit(
  //           UpdateFcmTokenStateError(message: dataState.exception?.parseMessage() ?? ""),
  //         );
  //       }
  //     case DataStateLoading<ApiResponse>():
  //       throw UnimplementedError();
  //   }
  // }
}
