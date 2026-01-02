import 'package:dio/dio.dart';

import '../data/api/api_service.dart';
import '../model/confirm_exchange_ticket_model.dart';
import '../model/exchange_ticket_model.dart';

class ExchangeTicketRepository {
  final ApiService _apiService;

  ExchangeTicketRepository(this._apiService);

  Future<ExchangeTicketModel> getOrderByCode(String codeOrder) async {
    try {
      final response = await _apiService.exchangeTicket(codeOrder: codeOrder);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Gagal mengambil data order');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Terjadi kesalahan');
      } else {
        throw Exception('Koneksi bermasalah');
      }
    } catch (e) {
      throw Exception('Error tidak diketahui: $e');
    }
  }

  Future<ConfirmExchangeTicketModel> confirmExchange({
    required int orderId,
    required String codeOrder,
  }) async {
    try {
      final response = await _apiService.confirmExchangeTicket(
        orderId: orderId,
        codeOrder: codeOrder,
      );

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Gagal menukar tiket');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Terjadi kesalahan');
      } else {
        throw Exception('Koneksi bermasalah');
      }
    } catch (e) {
      throw Exception('Error tidak diketahui: $e');
    }
  }
}