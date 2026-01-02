import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repository/exchange_ticket_repository.dart';
import 'exchange_ticket_state.dart';

class ExchangeTicketCubit extends Cubit<ExchangeTicketState> {
  final ExchangeTicketRepository _repository;

  ExchangeTicketCubit(this._repository) : super(ExchangeTicketInitial());

  Future<void> checkBookingCode(String code) async {
    if (code.trim().isEmpty) {
      emit(ExchangeTicketError('Kode booking tidak boleh kosong'));
      return;
    }
    emit(ExchangeTicketLoading());

    try {
      final order = await _repository.getOrderByCode(code);
      emit(ExchangeTicketSuccess(order));
    } catch (e) {
      emit(ExchangeTicketError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // Method baru untuk confirm exchange
  Future<void> confirmExchange({
    required int orderId,
    required String codeOrder,
  }) async {
    emit(ExchangeTicketExchanging());

    try {
      final result = await _repository.confirmExchange(
        orderId: orderId,
        codeOrder: codeOrder,
      );
      emit(ExchangeTicketExchanged(result));
    } catch (e) {
      emit(ExchangeTicketError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void reset() {
    emit(ExchangeTicketInitial());
  }
}