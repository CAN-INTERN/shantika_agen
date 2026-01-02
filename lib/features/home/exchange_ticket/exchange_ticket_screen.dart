import 'package:flutter/material.dart';
import 'package:shantika_agen/features/home/exchange_ticket/detail_ticket_screen.dart';
import 'package:shantika_agen/features/home/exchange_ticket/qr_scanner_screen.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/typography.dart';
import '../../../ui/shared_widget/custom_arrow.dart';
import '../../../ui/shared_widget/custom_button.dart';
import '../../../ui/shared_widget/custom_text_form_field.dart';

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

  void _goToDetailTicket() {
    final code = _bookingCodeController.text.trim();

    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kode booking tidak boleh kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Langsung pindah ke detail ticket dengan kode booking
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailTicketScreen(
          bookingCode: code,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 40),
            _buildIllustration(),
            const SizedBox(height: 40),
            _buildBookingCodeForm(),
            const SizedBox(height: 24),
            _buildCheckButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
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
              const SizedBox(width: 12),
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
      child: CustomButton(
        backgroundColor: jacarta800,
        onPressed: _goToDetailTicket,
        width: double.infinity,
        height: 48,
        child: Text(
          "Periksa Kode Booking",
          style: mdMedium.copyWith(color: black00),
        ),
      ),
    );
  }
}