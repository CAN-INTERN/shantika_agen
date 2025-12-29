import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shantika_agen/features/profile/about%20us/about_us_screen.dart';
import 'package:shantika_agen/features/profile/faq/faq_screen.dart';
import 'package:shantika_agen/features/profile/notification/notification_screen.dart';
import 'package:shantika_agen/features/profile/personal%20information/personal_information.dart';
import 'package:shantika_agen/features/profile/privacy_policy/privacy_policy_screen.dart';
import 'package:shantika_agen/features/profile/review/rating_screen.dart';
import 'package:shantika_agen/features/profile/terms%20and%20condition/terms_condition_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card.dart';
import '../../ui/typography.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String name = "Shin Eunsoo";
  final int rating = 0;
  final String? avatarUrl = null;

  Future<String> getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: spacing6),
              GestureDetector(
                onTap: () {
                  if (avatarUrl != null && avatarUrl!.isNotEmpty) {
                    _showImagePreview(context, avatarUrl!);
                  }
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                      ? NetworkImage(avatarUrl!)
                      : AssetImage('assets/images/img_eunsoo.jpeg')
                  as ImageProvider,
                  backgroundColor: black500,
                ),
              ),

              SizedBox(height: spacing5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name, style: lgBold),
                  SizedBox(width: spacing3),
                  SvgPicture.asset('assets/icons/ic_rate_filled.svg', width: iconL),
                  SizedBox(width: space050),
                  Text('$rating', style: lgBold),
                ],
              ),

              SizedBox(height: spacing7),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding20),
                child: Column(
                  children: [
                    _menuItem(
                      svgIcon: 'assets/icons/id_profile_person.svg',
                      text: "Informasi Pribadi",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalInformation(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: spacing4),
                    _menuItem(
                      svgIcon: 'assets/icons/ic_notify.svg',
                      text: "Notifikasi",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: spacing4),
                    _ratingAgenCard(),

                    SizedBox(height: spacing4),
                    _menuItem(
                      svgIcon: 'assets/icons/ic_information.svg',
                      text: "Tentang Kami",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutUsScreen(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: spacing4),
                    _menuItem(
                      svgIcon: 'assets/icons/ic_privacy_policy.svg',
                      text: "Kebijakan Privasi",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicyScreen(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: spacing4),
                    _menuItem(
                      svgIcon: 'assets/icons/ic_document.svg',
                      text: "Syarat dan Ketentuan",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsConditionScreen(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: spacing4),
                    _menuItem(
                      svgIcon: 'assets/icons/ic_faq.svg',
                      text: "FAQ",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FaqScreen(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: spacing4),
                    FutureBuilder<String>(
                      future: getVersionInfo(),
                      builder: (context, snapshot) {
                        String versionText = "Versi ...";

                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            versionText = "Versi ${snapshot.data}";
                          } else {
                            versionText = "Versi -";
                          }
                        }

                        return _menuItem(
                          svgIcon: 'assets/icons/ic_stars_black.svg',
                          text: "Beri Nilai App Kami",
                          trailing: Text(
                            versionText,
                            style: xsMedium.copyWith(color: black600),
                          ),
                          onTap: _openStoreReview,
                        );
                      },
                    ),

                    SizedBox(height: spacing6),
                    CustomButton(
                      onPressed: () => _showLogoutDialog(context),
                      padding: EdgeInsets.symmetric(vertical: padding16),
                      child: Text('Keluar'),
                      backgroundColor: red600,
                    ),

                    SizedBox(height: spacing6),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Profil", style: xlBold),
          centerTitle: true,
          elevation: 0,
        ),
      ),
    );
  }

  Widget _menuItem({
    required String svgIcon,
    required String text,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius300),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: padding16,
          vertical: padding16,
        ),
        decoration: BoxDecoration(
          color: black00,
          borderRadius: BorderRadius.circular(borderRadius300),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgIcon,
              height: iconL,
            ),
            SizedBox(width: spacing4),
            Expanded(
              child: Text(text, style: smSemiBold),
            ),
            if (trailing != null) ...[
              trailing,
              SizedBox(width: space100),
            ],
          ],
        ),
      ),
    );
  }

  Widget _ratingAgenCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RatingScreen(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(borderRadius400),
      child: Container(
        padding: EdgeInsets.all(padding20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              blue600,
              blue700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius400),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(padding12),
              decoration: BoxDecoration(
                color: black00.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                width: 20,
                height: 20,
                'assets/icons/ic_rate_filled.svg',
                colorFilter: ColorFilter.mode(
                  black00,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: spacing4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rating Agen',
                    style: smBold.copyWith(color: black00),
                  ),
                  SizedBox(height: space150),
                  Text(
                    'Dapatkan bintang setiap konfirmasi tiket',
                    style: xsRegular.copyWith(color: black00),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius500),
          ),
          backgroundColor: black00,
          child: Padding(
            padding: EdgeInsets.all(padding20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: red600.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(borderRadius500),
                  ),
                  child: Icon(Icons.logout, color: red600, size: iconL),
                ),
                SizedBox(height: spacing5),
                Text("Keluar Akun", style: mdSemiBold),
                SizedBox(height: space200),
                Text(
                  "Yakin Anda akan keluar dari akun $name?",
                  style: smRegular.copyWith(color: black700_70),
                ),
                SizedBox(height: spacing6),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        padding: EdgeInsets.symmetric(vertical: paddingS),
                        child: Text('Batal'),
                        backgroundColor: black00,
                        textColor: black950,
                        borderColor: black700_70,
                      ),
                    ),
                    SizedBox(width: spacing4),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Logout berhasil!'),
                              backgroundColor: green400,
                            ),
                          );
                        },
                        padding: EdgeInsets.symmetric(vertical: paddingS),
                        child: Text('Keluar'),
                        backgroundColor: red600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openStoreReview() async {
    if (Platform.isAndroid) {
      final playStoreUrl = Uri.parse('market://');
      if (await canLaunchUrl(playStoreUrl)) {
        await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
      } else {
        final webUrl = Uri.parse('https://play.google.com/store');
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      }
    }
  }

  void _showImagePreview(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierColor: black950.withOpacity(0.9),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(padding20),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius300),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 5,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    padding: EdgeInsets.all(padding6),
                    decoration: BoxDecoration(
                      color: black950.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: black00,
                      size: iconL,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}