import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import '../../ui/shared_widget/custom_arrow.dart';

class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({super.key});

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {
  String? selectedStatus;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildFilterSection(),
          Expanded(
            child: _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const CustomArrow(title: "Riwayat");
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatusDropdown(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildDatePicker(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return GestureDetector(
      onTap: () => _showStatusBottomSheet(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedStatus ?? 'Pilih Status',
              style: TextStyle(
                fontSize: 14,
                color: selectedStatus == null ? Colors.grey.shade400 : Colors.black87,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () => _selectDate(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? 'Pilih Tanggal'
                  : '${selectedDate!.day} ${_getMonthName(selectedDate!.month)} ${selectedDate!.year}',
              style: TextStyle(
                fontSize: 14,
                color: selectedDate == null ? Colors.grey.shade400 : Colors.black87,
              ),
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey.shade400,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Box
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C3E7C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Stars
                Positioned(
                  top: 25,
                  right: 35,
                  child: Icon(
                    Icons.star,
                    color: Colors.amber.shade300,
                    size: 20,
                  ),
                ),
                Positioned(
                  top: 35,
                  right: 25,
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow.shade600,
                    size: 32,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 50,
                  child: Icon(
                    Icons.star,
                    color: Colors.amber.shade400,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Tidak menemukan riwayat',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showStatusBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            _buildStatusOption('Belum Dibayar'),
            _buildStatusOption('Menunggu Verifikasi'),
            _buildStatusOption('Selesai'),
            _buildStatusOption('Dibatalkan'),
            _buildStatusOption('Ditolak'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOption(String status) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedStatus = status;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          status,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
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
        selectedDate = picked;
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
}