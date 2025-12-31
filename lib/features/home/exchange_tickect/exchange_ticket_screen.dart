import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_agen/features/home/exchange_tickect/cubit/exchange_ticket_state.dart';
import 'package:shantika_agen/features/home/exchange_tickect/qr_scanner_screen.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/typography.dart';
import '../../../ui/shared_widget/custom_arrow.dart';
import '../../../ui/shared_widget/custom_button.dart';
import '../../../ui/shared_widget/custom_text_form_field.dart';
import 'cubit/exchange_ticket_cubit.dart';

class ExchangeTicketScreen extends StatefulWidget {
  const ExchangeTicketScreen({super.key});

  @override
  State<ExchangeTicketScreen> createState() => _ExchangeTicketScreenState();
}

class _ExchangeTicketScreenState extends State<ExchangeTicketScreen> {
  final TextEditingController _bookingCodeController = TextEditingController();

  @override
  void dispose() {
    _bookingCodeController.dispose();
    super.dispose();
  }

  void _openQRScanner() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QrScannerScreen(),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        _bookingCodeController.text = result;
      });
    }
  }

  void _checkBookingCode() {
    final code = _bookingCodeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Masukkan kode booking terlebih dahulu'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    context.read<ExchangeTicketCubit>().checkBookingCode(code);
  }

  // Helper method untuk safely get string value
  String _safeString(dynamic value, {String defaultValue = '-'}) {
    if (value == null) return defaultValue;
    return value.toString();
  }

  // Helper method untuk safely get seat passenger
  String _getSeatPassenger(dynamic seatPassenger) {
    if (seatPassenger == null) return '-';

    if (seatPassenger is List) {
      if (seatPassenger.isEmpty) return '-';
      return seatPassenger.map((e) => e?.toString() ?? '').where((s) => s.isNotEmpty).join(', ');
    }

    return seatPassenger.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      body: BlocListener<ExchangeTicketCubit, ExchangeTicketState>(
        listener: (context, state) {
          if (state is ExchangeTicketSuccess) {
            final order = state.order.order;
            _showOrderDetailsDialog(order);
          } else if (state is ExchangeTicketError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is ExchangeTicketExchanged) {
            // Tutup loading dialog
            Navigator.pop(context);
            // Tampilkan success dialog
            _showSuccessDialog(state.result);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 40),
              _buildIllustration(),
              SizedBox(height: 40),
              _buildBookingCodeForm(),
              SizedBox(height: 24),
              _buildCheckButton(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderDetailsDialog(order) {
    if (order == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data order tidak valid'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: black00,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text(
              'Order Ditemukan',
              style: lgBold.copyWith(color: black950),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Kode Order', _safeString(order.codeOrder)),
              Divider(color: black100),
              _buildInfoRow('Penumpang', _safeString(order.namePassenger)),
              _buildInfoRow('Telepon', _safeString(order.phonePassenger)),
              Divider(color: black100),
              _buildInfoRow('Armada', _safeString(order.nameFleet)),
              _buildInfoRow('Kelas', _safeString(order.fleetClass)),
              _buildInfoRow('Kursi', _getSeatPassenger(order.seatPassenger)),
              Divider(color: black100),
              _buildInfoRow('Dari', _safeString(order.checkpoints?.start?.agencyName)),
              _buildInfoRow('Tujuan', _safeString(order.checkpoints?.destination?.agencyName)),
              _buildInfoRow('Ke', _safeString(order.checkpoints?.end?.agencyName)),
              Divider(color: black100),
              _buildInfoRow('Status', _safeString(order.status),
                  valueColor: _safeString(order.status) == 'PAID' ? Colors.green : Colors.orange),
              _buildInfoRow(
                  'Total',
                  order.totalPrice != null ? 'Rp ${_formatCurrency(order.totalPrice)}' : 'Rp 0',
                  valueColor: jacarta800
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ExchangeTicketCubit>().reset();
              _bookingCodeController.clear();
            },
            child: Text(
              'Tutup',
              style: mdMedium.copyWith(color: black300),
            ),
          ),
          CustomButton(
            backgroundColor: jacarta800,
            onPressed: () {
              Navigator.pop(context); // Tutup dialog detail
              _performExchange(order); // Panggil fungsi exchange
            },
            height: 44,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Tukar Tiket',
                style: mdMedium.copyWith(color: black00),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _performExchange(order) {
    // Validasi order id dan code order
    if (order.id == null || order.codeOrder == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data order tidak lengkap'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: black00,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: jacarta800),
              SizedBox(height: 16),
              Text(
                'Memproses tukar tiket...',
                style: mdMedium.copyWith(color: black950),
              ),
            ],
          ),
        ),
      ),
    );

    // Panggil API confirm exchange
    context.read<ExchangeTicketCubit>().confirmExchange(
      orderId: order.id!,
      codeOrder: order.codeOrder!,
    );
  }

  void _showSuccessDialog(result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: black00,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 64),
            SizedBox(height: 16),
            Text(
              'Tiket Berhasil Ditukar!',
              style: lgBold.copyWith(color: black950),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Penukaran tiket berhasil dilakukan',
              style: mdRegular.copyWith(color: black300),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            if (result.id != null || result.agencyId != null) ...[
              Divider(color: black100),
              if (result.id != null)
                _buildInfoRow('ID Exchange', result.id.toString()),
              if (result.agencyId != null)
                _buildInfoRow('Agency ID', result.agencyId.toString()),
            ],
          ],
        ),
        actions: [
          CustomButton(
            backgroundColor: jacarta800,
            onPressed: () {
              Navigator.pop(context); // Tutup success dialog
              context.read<ExchangeTicketCubit>().reset();
              _bookingCodeController.clear();
            },
            width: double.infinity,
            height: 44,
            child: Text(
              'Selesai',
              style: mdMedium.copyWith(color: black00),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: smMedium.copyWith(color: black300),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: smSemiBold.copyWith(
                color: valueColor ?? black950,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
    );
  }

  Widget _buildHeader() {
    return CustomArrow(title: "Data Pemesanan");
  }

  Widget _buildIllustration() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Image.asset(
        'assets/images/img_qr.png',
        width: 250,
      ),
    );
  }

  Widget _buildBookingCodeForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomTextFormField(
                  titleSection: "Masukan Tiket Booking",
                  controller: _bookingCodeController,
                  placeholder: 'NS00000167',
                ),
              ),
              SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: GestureDetector(
                  onTap: _openQRScanner,
                  child: Image.asset(
                    "assets/images/img_qr_scanner.png",
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: BlocBuilder<ExchangeTicketCubit, ExchangeTicketState>(
        builder: (context, state) {
          final isLoading = state is ExchangeTicketLoading;

          return CustomButton(
            backgroundColor: isLoading ? jacarta800.withOpacity(0.6) : jacarta800,
            onPressed: isLoading ? null : _checkBookingCode,
            width: double.infinity,
            height: 48,
            child: isLoading
                ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: black00,
                strokeWidth: 2.5,
              ),
            )
                : Text(
              "Periksa Kode Booking",
              style: mdMedium.copyWith(color: black00),
            ),
          );
        },
      ),
    );
  }
}