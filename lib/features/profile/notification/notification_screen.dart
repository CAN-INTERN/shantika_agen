import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isAktivitasEnabled = true;
  bool isSpesialEnabled = true;
  bool isPengingatEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Pengaturan Notifikasi",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              // Aktifitas Section
              _buildNotificationSection(
                title: "Aktifitas",
                description:
                "Pastikan akunmu aman dengan memantau aktivitas login, register hingga notifikasi OTP.",
                isEnabled: isAktivitasEnabled,
                onChanged: (value) {
                  setState(() {
                    isAktivitasEnabled = value;
                  });
                },
              ),
              SizedBox(height: 24),
              // Spesial Untuk Kamu Section
              _buildNotificationSection(
                title: "Spesial Untuk Kamu",
                description:
                "Kesempatan mendapat diskon terbatas, penawaran, tips, dan info fitur terbaru.",
                isEnabled: isSpesialEnabled,
                onChanged: (value) {
                  setState(() {
                    isSpesialEnabled = value;
                  });
                },
              ),
              SizedBox(height: 24),
              // Pengingat Section
              _buildNotificationSection(
                title: "Pengingat",
                description:
                "Dapatkan berita dan info perjalanan penting, pengingat pembayaran, booking, dan lainnya.",
                isEnabled: isPengingatEnabled,
                onChanged: (value) {
                  setState(() {
                    isPengingatEnabled = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationSection({
    required String title,
    required String description,
    required bool isEnabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        // Description
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
        SizedBox(height: 12),
        // Push Notification Toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Push Notification",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: isEnabled,
                onChanged: onChanged,
                activeColor: black00,
                activeTrackColor: primaryColor,
                inactiveThumbColor: black00,
                inactiveTrackColor: black700_70,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}