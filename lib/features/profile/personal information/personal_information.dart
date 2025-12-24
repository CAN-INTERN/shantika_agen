import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/typography.dart';

import '../../../ui/shared_widget/show_toast.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: AppBar(
        backgroundColor: black00,
        elevation: 0,
        surfaceTintColor: black00,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: black950),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Perbarui Profil",
          style: xlBold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: space200),
              _buildProfileSection(context),
              SizedBox(height: space800),
              _buildTextField(
                label: "Email",
                value: "kkaylanasywa@gmail.com",
              ),
              SizedBox(height: spacing6),
              _buildTextField(
                label: "Nomor Telepon",
                value: "+6281234567994",
              ),
              SizedBox(height: spacing6),
              _buildTextField(
                label: "Jenis Kelamin",
                value: "Pria",
              ),
              SizedBox(height: spacing6),
              _buildTextField(
                label: "Alamat Lengkap",
                value: "Semarang",
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: black300,
              backgroundImage: AssetImage('assets/images/img_eunsoo.jpeg'),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: black950.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _showImagePickerBottomSheet(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(padding12),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset('assets/icons/ic_camera_outline.svg'),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: spacing5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "JEPARA, JEPARA",
                style: mdSemiBold,
              ),
              SizedBox(height: space150),
              Row(
                children: [
                  Text(
                    "Agen Terverifikasi",
                    style: smMedium.copyWith(color: black700_70),
                  ),
                  SizedBox(width: space100),
                  Icon(
                    Icons.verified,
                    size: iconS,
                    color: blue400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: smMedium,
        ),
        SizedBox(height: space200),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: padding16,
            vertical: maxLines > 1 ? 16 : 14,
          ),
          decoration: BoxDecoration(
            color: black00,
            borderRadius: BorderRadius.circular(space200),
            border: Border.all(
              color: black300!,
              width: 1,
            ),
          ),
          child: Text(
            value,
            style: mdMedium,
            maxLines: maxLines,
          ),
        ),
      ],
    );
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: black400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius500),
          ),
          child: Padding(
            padding: EdgeInsets.all(space800),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih',
                  style: xlBold.copyWith(color: black00),
                ),
                SizedBox(height: space1000),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageOption(
                      context: context,
                      bottomSheetContext: dialogContext,
                      icon: Icons.camera_alt,
                      label: 'Kamera',
                      onTap: () {
                        Navigator.pop(dialogContext);
                        CustomToast.showSuccess(context, 'Kamera dipilih');
                      },
                    ),
                    _buildImageOption(
                      context: context,
                      bottomSheetContext: dialogContext,
                      icon: Icons.image,
                      label: 'Galeri',
                      onTap: () {
                        Navigator.pop(dialogContext);
                        CustomToast.showSuccess(context, 'Galeri dipilih');
                      },
                    ),
                  ],
                ),
                SizedBox(height: space800),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(dialogContext),
                    child: Text(
                      'BATAL',
                      style: mdSemiBold.copyWith(color: primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageOption({
    required BuildContext context,
    required BuildContext bottomSheetContext,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            child: Icon(
              icon,
              size: iconXXL,
              color: black600,
            ),
          ),
          SizedBox(height: space100),
          Text(
            label,
            style: mdMedium.copyWith(color: black300),
          ),
        ],
      ),
    );
  }
}