import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/shared_widget/custom_arrow.dart';
import 'package:shantika_agen/ui/typography.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = true;

    return Scaffold(
      backgroundColor: black00,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            if (isEmpty)
              _buildEmptyState()
            else
              _buildNotificationList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      child: CustomArrow(title: "Notifikasi"),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 130),
            Image.asset(
              'assets/images/ic_notifikasi_kosong.png',
              width: 150,
            ),
             SizedBox(height: 24),
            Text(
              'Belum Ada notifikasi untuk anda',
              style: mdMedium
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    return Container();
  }
}