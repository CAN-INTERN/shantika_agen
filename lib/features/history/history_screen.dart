import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/shared_widget/custom_button.dart';
import 'package:shantika_agen/ui/typography.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedDateIndex = 0;
  final List<Map<String, String>> dates = [
    {'day': '22', 'month': 'Des 2025'},
    {'day': '23', 'month': 'Des 2025'},
    {'day': '24', 'month': 'Des 2025'},
  ];

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
                      Text('Tagihan 22 Desember 2025',
                          style: smRegular.copyWith(color: black00)),
                      SizedBox(height: 8),
                      Text('Rp0', style: lSemiBold.copyWith(color: black00)),
                    ],
                  ),
                  CustomButton(
                      onPressed: () {},
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ...List.generate(dates.length, (index) {
            final isSelected = selectedDateIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDateIndex = index;
                  });
                },
                child: Container(
                  margin:
                      EdgeInsets.only(right: index < dates.length - 1 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? jacarta400 : black00,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(dates[index]['day']!,
                          style: mlBold.copyWith(
                            color: isSelected ? black00 : black950,
                          )),
                      const SizedBox(height: 4),
                      Text(dates[index]['month']!,
                          style: xsRegular.copyWith(
                            color: isSelected ? black00 : black950,
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: black00,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pilih Tanggal',
                    style: xxsRegular,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
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
        String day = picked.day.toString();
        String month = _getMonthName(picked.month);
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
