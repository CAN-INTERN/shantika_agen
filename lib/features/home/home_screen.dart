import 'package:flutter/material.dart';
import 'package:shantika_agen/features/fleet/list_fleet_screen.dart';
import 'package:shantika_agen/features/home/exchange_ticket_screen.dart';
import 'package:shantika_agen/ui/shared_widget/custom_button.dart';
import 'package:shantika_agen/ui/shared_widget/custom_card_container.dart';
import 'package:shantika_agen/ui/shared_widget/custom_text_form_field.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/typography.dart';
import '../../model/agency_model.dart';
import '../../model/time_classification_model.dart';
import '../../ui/shared_widget/custom_bottom_sheet.dart';
import '../../ui/shared_widget/custom_card.dart';
import '../notification/notification_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

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

  final List<String> busClasses = [
    'Executive',
  ];

  DateTime? selectedDate;
  Agency? selectedAgency;
  Time? selectedTime;
  String? selectedClass;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: jacarta800,
              onPrimary: black00,
              onSurface: black950,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      setState(() {
        selectedDate = picked;
        String day = picked.day.toString().padLeft(2, '0');
        String month = _getMonthName(picked.month);
        String year = picked.year.toString();
        _dateController.text = '$day $month $year';
      });
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return months[month - 1];
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _classController.dispose();
    super.dispose();
  }

  void _showDestinationBottomSheet() {
    context.read<HomeCubit>().fetchAgencies();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final isLoading = state is HomeLoading;
          final isError = state is HomeError;
          final agencies = state is HomeLoaded ? state.agencies : <Agency>[];
          final errorMessage = isError ? (state as HomeError).message : null;

          return SelectionBottomSheet<Agency>(
            title: 'Pilih Tujuan',
            items: agencies,
            selectedItem: selectedAgency,
            onItemSelected: (agency) {
              if (mounted) {
                setState(() {
                  selectedAgency = agency;
                  final agencyName = agency.agencyName ?? '';
                  final cityName = agency.cityName ?? '';
                  _destinationController.text = '$agencyName - $cityName';
                });
              }
            },
            getItemName: (agency) {
              final agencyName = agency.agencyName ?? '';
              final cityName = agency.cityName ?? '';
              return '$agencyName - $cityName';
            },
            getItemId: (agency) => agency.id?.toString(),
            searchHint: 'Cari Tujuan',
            isLoading: isLoading,
            errorMessage: errorMessage,
            onRetry: () {
              context.read<HomeCubit>().fetchAgencies();
            },
            showSearch: true,
            emptyStateMessage: 'Tidak ada tujuan ditemukan',
          );
        },
      ),
    );
  }

  void _showTimeBottomSheet() {
    context.read<HomeCubit>().fetchTimeClassifications();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final isLoading = state is TimeClassificationLoading;
          final isError = state is TimeClassificationError;
          final timeClassifications = state is TimeClassificationLoaded
              ? state.timeClassifications
              : <Time>[];
          final errorMessage =
              isError ? (state as TimeClassificationError).message : null;

          return SelectionBottomSheet<Time>(
            title: 'Pilih Waktu',
            items: timeClassifications,
            selectedItem: selectedTime,
            onItemSelected: (time) {
              if (mounted) {
                setState(() {
                  selectedTime = time;
                  final timeName = time.name ?? '';
                  final timeStart = time.timeStart ?? '';
                  _timeController.text = '$timeName $timeStart';
                });
              }
            },
            getItemName: (time) {
              final timeName = time.name ?? '';
              final timeStart = time.timeStart ?? '';
              return '$timeName $timeStart WIB';
            },
            getItemId: (time) => time.id?.toString(),
            searchHint: 'Cari Waktu',
            isLoading: isLoading,
            errorMessage: errorMessage,
            onRetry: () {
              context.read<HomeCubit>().fetchTimeClassifications();
            },
            showSearch: false,
            emptyStateMessage: 'Tidak ada waktu tersedia',
          );
        },
      ),
    );
  }

  void _showClassBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionBottomSheet<String>(
        title: 'Pilih Kelas Armada',
        items: busClasses,
        selectedItem: selectedClass,
        onItemSelected: (busClass) {
          if (mounted) {
            setState(() {
              selectedClass = busClass;
              _classController.text = busClass;
            });
          }
        },
        getItemName: (busClass) => busClass,
        getItemId: (busClass) => busClass,
        searchHint: 'Cari Armada',
        isLoading: false,
        showSearch: true,
        emptyStateMessage: 'Tidak ada kelas tersedia',
      ),
    );
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
            onTap: _showDestinationBottomSheet,
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
                  onTap: () => _selectDate(context),
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
                  onTap: _showTimeBottomSheet,
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
            onTap: _showClassBottomSheet,
          ),
          SizedBox(height: 20),
          CustomButton(
            backgroundColor: jacarta800,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListFleetScreen(),
                ),
              );
            },
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
                  Text('Penukaran E-Tiket',
                      style: lgSemiBold.copyWith(color: black00)),
                  SizedBox(height: 4),
                  Text('Lakukan penukaran tiket pelanggan disini',
                      style: xsMedium.copyWith(color: black00)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
