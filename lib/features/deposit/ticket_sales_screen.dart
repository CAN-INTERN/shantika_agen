import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import '../../ui/shared_widget/custom_arrow.dart';
import '../../ui/shared_widget/empty_state_view.dart';
import '../../config/constant.dart';

class TicketSalesScreen extends StatefulWidget {
  const TicketSalesScreen({super.key});

  @override
  State<TicketSalesScreen> createState() => _TicketSalesScreenState();
}

class _TicketSalesScreenState extends State<TicketSalesScreen> {
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
                  title: 'Tidak ada data setoran untuk anda',
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
    return const CustomArrow(title: "Detail Setoran");
  }

  void _reloadData() {
    // Add your reload logic here
    setState(() {
      // Trigger data reload
    });
  }
}