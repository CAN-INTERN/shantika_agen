import 'package:flutter/material.dart';
import 'package:shantika_agen/features/fleet/list_fleet_screen.dart';
import 'package:shantika_agen/features/home/exchange_ticket/exchange_ticket_screen.dart';
import 'package:shantika_agen/ui/shared_widget/custom_button.dart';
import 'package:shantika_agen/ui/shared_widget/custom_card_container.dart';
import 'package:shantika_agen/ui/shared_widget/custom_text_form_field.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/typography.dart';
import '../../model/agency_model.dart';
import '../../model/fleet_class_model.dart';
import '../../model/time_classification_model.dart';
import '../../ui/shared_widget/custom_bottom_sheet.dart';
import '../../ui/shared_widget/custom_card.dart';
import '../../utility/extensions/date_time_extensions.dart';
import '../../utility/extensions/show_toast.dart';
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

  DateTime? selectedDate;
  Agency? selectedAgency;
  Time? selectedTime;
  FleetClass? selectedFleetClass;

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
        String month = picked.month.toMonthName();
        String year = picked.year.toString();
        _dateController.text = '$day $month $year';
      });
    }
  }

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
            readOnly: true,
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
                  maxLines: 1,
                  readOnly: true,
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
                  readOnly: true,
                  maxLines: 1,
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
            readOnly: true,
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

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SelectionBottomSheet<Agency>(
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
                    selectedFleetClass = null;
                    _classController.clear();
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
            ),
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

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SelectionBottomSheet<Time>(
              title: 'Pilih Waktu',
              items: timeClassifications,
              selectedItem: selectedTime,
              onItemSelected: (time) {
                if (mounted) {
                  setState(() {
                    selectedTime = time;
                    final timeName = time.name ?? '';
                    final timeStart = (time.timeStart ?? '').formatTimeStart();
                    _timeController.text = '$timeName $timeStart';

                    selectedFleetClass = null;
                    _classController.clear();
                  });
                }
              },
              getItemName: (time) {
                final timeName = time.name ?? '';
                final timeStart = (time.timeStart ?? '').formatTimeStart();
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
            ),
          );
        },
      ),
    );
  }

  void _showClassBottomSheet() {
    if (selectedAgency == null) {
      context.showCustomToast(
        title: 'Perhatian',
        message: 'Silakan pilih tempat tujuan terlebih dahulu',
        isSuccess: false,
      );
      return;
    }

    if (selectedDate == null) {
      context.showCustomToast(
        title: 'Perhatian',
        message: 'Silakan pilih tanggal keberangkatan terlebih dahulu',
        isSuccess: false,
      );
      return;
    }

    if (selectedTime == null) {
      context.showCustomToast(
        title: 'Perhatian',
        message: 'Silakan pilih waktu berangkat terlebih dahulu',
        isSuccess: false,
      );
      return;
    }

    context.read<HomeCubit>().fetchAvailableFleetClasses(
      agencyId: selectedAgency!.id ?? 0,
      timeClassificationId: selectedTime!.id ?? 0,
      date: selectedDate!.toApiFormat(),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final isLoading = state is FleetClassLoading;
          final isError = state is FleetClassError;
          final fleetClasses =
          state is FleetClassLoaded ? state.fleetClasses : <FleetClass>[];
          final errorMessage =
          isError ? (state as FleetClassError).message : null;

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SelectionBottomSheet<FleetClass>(
              title: 'Pilih Kelas Armada',
              items: fleetClasses,
              selectedItem: selectedFleetClass,
              onItemSelected: (fleetClass) {
                if (mounted) {
                  setState(() {
                    selectedFleetClass = fleetClass;
                    _classController.text = fleetClass.name ?? '';
                  });
                }
              },
              getItemName: (fleetClass) {
                final name = fleetClass.name ?? '';
                return '$name';
              },
              getItemId: (fleetClass) => fleetClass.id?.toString(),
              searchHint: 'Cari Armada',
              isLoading: isLoading,
              errorMessage: errorMessage,
              onRetry: () {
                context.read<HomeCubit>().fetchAvailableFleetClasses(
                  agencyId: selectedAgency!.id ?? 0,
                  timeClassificationId: selectedTime!.id ?? 0,
                  date: selectedDate!.toApiFormat(),
                );
              },
              showSearch: true,
              emptyStateMessage: 'Tidak ada kelas armada tersedia',
            ),
          );
        },
      ),
    );
  }
}
