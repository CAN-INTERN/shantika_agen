import 'package:flutter/material.dart';
import 'package:shantika_agen/features/home/exchange_tickect/exchange_ticket_screen.dart';
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

  final List<String> destinations = [
    'BADAMI-KARAWANG',
    'BALA RAJA-SERANG',
    'BANDUNG-BANDUNG',
    'BARANANGSIANG-BOGOR',
    'BEKASI BARAT-BEKASI',
    'BEKASI TIMUR-BEKASI',
    'BITUNG-TANGERANG',
    'BOGOR-BOGOR',
    'BSD-TANGERANG',
    'BUBULAK-BOGOR',
  ];

  final List<Map<String, String>> timeSlots = [
    {'label': 'Pagi', 'time': '07:00:00'},
    {'label': 'Sore', 'time': '15:30:00'},
    {'label': 'Malam', 'time': '18:00:00'},
  ];

  final List<String> busClasses = [
    'Executive',
  ];

  List<String> filteredDestinations = [];
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    filteredDestinations = destinations;
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

    if (picked != null) {
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
    final TextEditingController searchController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          void filterDestinations(String query) {
            setModalState(() {
              if (query.isEmpty) {
                filteredDestinations = destinations;
              } else {
                filteredDestinations = destinations
                    .where((destination) =>
                    destination.toLowerCase().contains(query.toLowerCase()))
                    .toList();
              }
            });
          }

          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 20),

                // Search field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterDestinations,
                    decoration: InputDecoration(
                      hintText: 'Cari Tujuan',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Destination list
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredDestinations.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: Colors.grey[200],
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _destinationController.text =
                            filteredDestinations[index];
                          });
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            filteredDestinations[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ).whenComplete(() {
      searchController.dispose();
      setState(() {
        filteredDestinations = destinations;
      });
    });
  }

  void _showTimeBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 24),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pilih Waktu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Time list
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                final timeSlot = timeSlots[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _timeController.text =
                      '${timeSlot['label']} ${timeSlot['time']}';
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      '${timeSlot['label']} ${timeSlot['time']} WIB',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showClassBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 24),

            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Armada',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Class list
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: busClasses.length,
              itemBuilder: (context, index) {
                final busClass = busClasses[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _classController.text = busClass;
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      busClass,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
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