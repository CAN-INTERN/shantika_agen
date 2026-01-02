import 'package:equatable/equatable.dart';
import '../../../../model/exchange_ticket_model.dart';
import '../../../../model/confirm_exchange_ticket_model.dart';  // Tambahkan ini

abstract class ExchangeTicketState extends Equatable {
  const ExchangeTicketState();

  @override
  List<Object?> get props => [];
}

class ExchangeTicketInitial extends ExchangeTicketState {}

class ExchangeTicketLoading extends ExchangeTicketState {}

class ExchangeTicketSuccess extends ExchangeTicketState {
  final ExchangeTicketModel order;

  const ExchangeTicketSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

class ExchangeTicketError extends ExchangeTicketState {
  final String message;

  const ExchangeTicketError(this.message);

  @override
  List<Object?> get props => [message];
}

// State baru untuk proses exchange
class ExchangeTicketExchanging extends ExchangeTicketState {}

class ExchangeTicketExchanged extends ExchangeTicketState {
  final ConfirmExchangeTicketModel result;

  const ExchangeTicketExchanged(this.result);

  @override
  List<Object?> get props => [result];
}