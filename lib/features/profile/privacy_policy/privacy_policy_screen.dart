import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          "Kebijakan Privasi",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Title
            Text(
              "Kebijakan Privasi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            // Subtitle
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Kebijakan Privasi Aplikasi Shantika Bus",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Content
            Text(
              "Dengan menggunakan layanan kami, Anda mempercayakan informasi Anda kepada kami. Kebijakan Privasi ini bertujuan untuk membantu Anda memahami data yang kami kumpulkan, alasan kami mengumpulkannya, dan apa yang kami lakukan dengannya. Penggunaan Aplikasi Shantika Bus dan setiap fitur dan/atau layanan yang tersedia di Aplikasi Shantika Bus adalah bentuk persetujuan Anda terhadap Ketentuan Penggunaan dan Kebijakan Privasi ini. Oleh karena itu, harap baca Kebijakan Privasi ini dengan cermat untuk memastikan bahwa Anda memahami sepenuhnya sebelum mendaftar, mengakses, dan/atau menggunakan Aplikasi dan Layanan kami.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                height: 1.6,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24),

            // Section A
            Text(
              "A. Definisi",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            // Subsection
            Text(
              "a. Data Pribadi",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),

            Text(
              "Data pribadi berarti setiap informasi yang berkaitan dengan orang yang diidentifikasi atau dapat diidentifikasi (\"subjek data\"); orang perorangan yang dapat diidentifikasi adalah orang yang dapat diidentifikasi,",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                height: 1.6,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}