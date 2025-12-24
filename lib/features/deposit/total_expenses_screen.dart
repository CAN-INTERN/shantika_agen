import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import '../../ui/shared_widget/custom_arrow.dart';
import '../../ui/shared_widget/empty_state_view.dart';
import '../../config/constant.dart';

class TotalExpensesScreen extends StatefulWidget {
  const TotalExpensesScreen({super.key});

  @override
  State<TotalExpensesScreen> createState() => _TotalExpensesScreenState();
}

class _TotalExpensesScreenState extends State<TotalExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: EmptyStateView(
                  title: 'Anda Belum menambahkan pengeluaran',
                  imagePath: 'assets/images/img_no_deposit.png',
                  isSvg: false,
                  onPressed: () => _reloadData(),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const CustomArrow(title: "Pengeluaran");
  }

  void _reloadData() {
    // Add your reload logic here
    setState(() {
      // Trigger data reload
    });
  }
}