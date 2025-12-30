import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/shared_widget/custom_button.dart';
import 'package:shantika_agen/ui/typography.dart';

import '../deposit/deposit_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedDateIndex = 0;
  List<Map<String, String>> dates = [];
  DateTime? selectedCustomDate;

  @override
  void initState() {
    super.initState();
    _generateCurrentMonthDates();
  }

  void _generateCurrentMonthDates() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    dates.clear();
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(now.year, now.month, day);
      dates.add({
        'day': day.toString(),
        'month': '${_getMonthName(date.month)} ${date.year}',
        'fullDate': date.toString(),
      });
    }

    // Set selected index to current day
    selectedDateIndex = now.day - 1;
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = true;
    return Scaffold(
      backgroundColor: black00,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildBalanceCard(),
              const SizedBox(height: 16),
              _buildDateSelector(),
              const SizedBox(height: 24),
              isEmpty ? _buildEmptyState() : _buildHistoryList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Riwayat',
        style: lgBold,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBalanceCard() {
    String selectedDateText;
    if (selectedDateIndex >= 0 && selectedDateIndex < dates.length) {
      final date = dates[selectedDateIndex];
      selectedDateText = '${date['day']} ${date['month']}';
    } else if (selectedCustomDate != null) {
      selectedDateText = '${selectedCustomDate!.day} ${_getMonthName(selectedCustomDate!.month)} ${selectedCustomDate!.year}';
    } else {
      selectedDateText = '${dates[0]['day']} ${dates[0]['month']}';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/img_bg_riwayat.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tagihan $selectedDateText',
                          style: smRegular.copyWith(color: black00)),
                      SizedBox(height: 8),
                      Text('Rp0', style: lSemiBold.copyWith(color: black00)),
                    ],
                  ),
                  CustomButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepositDetailScreen(),
                          ),
                        );
                      },
                      backgroundColor: black00,
                      width: 95,
                      height: 35,
                      child: Text(
                        "Setoran",
                        style: smMedium.copyWith(color: jacarta800),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: dates.length + 1, // +1 for the calendar picker
        itemBuilder: (context, index) {
          if (index == dates.length) {
            // Calendar picker button
            return GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                width: 80,
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: selectedDateIndex == -1 ? jacarta400 : black00,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedDateIndex == -1 ? jacarta400 : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 24,
                      color: selectedDateIndex == -1 ? black00 : black950,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pilih Tanggal',
                      style: xxsRegular.copyWith(
                        color: selectedDateIndex == -1 ? black00 : black950,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          final isSelected = selectedDateIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDateIndex = index;
                selectedCustomDate = null;
              });
            },
            child: Container(
              width: 80,
              margin: EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: isSelected ? jacarta400 : black00,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? jacarta400 : Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(dates[index]['day']!,
                      style: mlBold.copyWith(
                        color: isSelected ? black00 : black950,
                      )),
                  const SizedBox(height: 4),
                  Text(dates[index]['month']!,
                      style: xxsRegular.copyWith(
                        color: isSelected ? black00 : black950,
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedCustomDate ?? DateTime.now(),
      firstDate: DateTime(2020),
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
        selectedDateIndex = -1;
        selectedCustomDate = picked;
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

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          SizedBox(height: 40),
          Image.asset(
            'assets/images/ic_riwayat_kosong.png',
            width: 130,
          ),
          SizedBox(height: 24),
          Text(
            'Maaf... belum ada riwayat pemesanan\npada hari terpilih',
            style: mdRegular,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          CustomButton(
            onPressed: () {},
            width: 150,
            height: 40,
            backgroundColor: black00,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
            child: Text(
              'ULANGI',
              style: smMedium.copyWith(color: black950),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return Container();
  }
}