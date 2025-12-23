import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../config/service_locator.dart';
import '../../../config/user_preference.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  late UserPreference _userPreference;

  void init() {
    _userPreference = serviceLocator.get();
    print('LoginCubit initialized');
  }

  Future<void> login({required String phone}) async {
    print('Starting login with phone: $phone');
    emit(LoginStateLoading());

    await Future.delayed(Duration(seconds: 2));

    if (phone.isEmpty) {
      emit(LoginStateError(message: 'Nomor telepon tidak boleh kosong'));
      return;
    }

    if (phone.length < 10) {
      emit(LoginStateError(message: 'Nomor telepon tidak valid'));
      return;
    }

    final dummyToken = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';

    await _userPreference.setToken(dummyToken);
    print('Token saved: ${dummyToken.substring(0, 20)}...');

    emit(LoginStateSuccess(token: dummyToken));
  }

  Future<void> loginWithGoogle() async {
    print('🔍 Starting Google login (dummy)');

    // Simulasi proses login
    await Future.delayed(Duration(seconds: 1));

    // Generate dummy token
    final dummyToken = 'google_token_${DateTime.now().millisecondsSinceEpoch}';

    // Save token
    await _userPreference.setToken(dummyToken);
    print('✅ Google token saved: ${dummyToken.substring(0, 20)}...');

    // Emit success state
    emit(LoginStateSuccess(token: dummyToken));
  }

  Future<void> logout() async {
    await _userPreference.clearData();
    emit(LoginInitial());
  }
}