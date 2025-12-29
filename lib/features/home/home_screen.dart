import 'package:flutter/material.dart';
import 'package:shantika_agen/features/home/exchange_ticket_screen.dart';
import 'package:shantika_agen/ui/shared_widget/custom_button.dart';
import 'package:shantika_agen/ui/shared_widget/custom_card_container.dart';
import 'package:shantika_agen/ui/shared_widget/custom_text_form_field.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/typography.dart';
import '../../ui/shared_widget/custom_card.dart';
import '../notification/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _classController = TextEditingController();

  @override
  void dispose() {
    _destinationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _classController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 36),
                _buildHeaderView(context),
                SizedBox(height: 24),
                _buildBannerSection(),
                SizedBox(height: 16),
                _buildBookingCard(context),
                SizedBox(height: 16),
                _buildETicketCard(context),
                SizedBox(height: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.09),
          Image.asset(
            'assets/images/img_logo_shantika.png',
            width: 150,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              );
            },
            icon: Icon(Icons.notifications),
            color: black00,
          )
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/images/red_bus.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context) {
    return CustomCardContainer(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      borderColor: black100,
      borderRadius: 16,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cek Ketersediaan Armada', style: xlRegular),
          SizedBox(height: 20),
          CustomTextFormField(
            titleSection: 'Tempat Tujuan',
            controller: _destinationController,
            placeholder: 'Pilih Tempat Tujuan',
            titleStyle: smRegular.copyWith(color: black950),
            placeholderStyle: smRegular.copyWith(color: black950),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                flex: 6,
                child: CustomTextFormField(
                  titleSection: 'Tanggal Keberangkatan',
                  controller: _dateController,
                  placeholder: 'Pilih Tanggal',
                  titleStyle: smRegular.copyWith(color: black950),
                  placeholderStyle: smRegular.copyWith(color: black950),
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                flex: 4,
                child: CustomTextFormField(
                  titleSection: 'Waktu Berangkat',
                  controller: _timeController,
                  placeholder: 'Pilih Waktu',
                  titleStyle: smRegular.copyWith(color: black950),
                  placeholderStyle: smRegular.copyWith(color: black950),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          CustomTextFormField(
            titleSection: 'Kelas Keberangkatan',
            controller: _classController,
            placeholder: 'Pilih Armada',
            titleStyle: smRegular.copyWith(color: black950),
            placeholderStyle: smRegular.copyWith(color: black950),
          ),
          SizedBox(height: 20),
          CustomButton(
            backgroundColor: jacarta800,
            onPressed: () {},
            width: double.infinity,
            height: 48,
            child: Text(
              "Cari",
              style: mdMedium.copyWith(color: black00),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildETicketCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomCard(
        padding: const EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(16),
        color: tosca,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExchangeTicketScreen(),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.confirmation_number_outlined,
                color: Colors.white,
                size: 32,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Penukaran E-Tiket',
                    style: lgSemiBold.copyWith(color: black00)
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Lakukan penukaran tiket pelanggan disini',
                    style: xsMedium.copyWith(color: black00)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }}
