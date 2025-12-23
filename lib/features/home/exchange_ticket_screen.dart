import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/typography.dart';

import '../../ui/shared_widget/custom_arrow.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      body: SingleChildScrollView(
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
            children: [
              Expanded(
                child: CustomTextFormField(
                  titleSection: "Masukan Tiket Booking",
                  controller: _bookingCodeController,
                  placeholder: 'NSTK24223232',
                ),
              ),
              SizedBox(width: 12),
              Image.asset(
                "assets/images/img_qr_scanner.png",
                width: 28,
              )
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
        onPressed: () {},
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
