import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import '../../ui/shared_widget/custom_arrow.dart';
import '../../ui/shared_widget/empty_state_view.dart';
import '../../config/constant.dart';

class BusScreen extends StatefulWidget {
  const BusScreen({super.key});

  @override
  State<BusScreen> createState() => _BusScreenState();
}

class _BusScreenState extends State<BusScreen> {
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
                  title: 'Belum ada rating untuk anda',
                  imagePath: 'assets/images/img_empty_start.png',
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
    return const CustomArrow(title: "Bus Dipesan");
  }

  void _reloadData() {
    setState(() {
    });
  }
}