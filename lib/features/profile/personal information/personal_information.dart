import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shantika_agen/config/user_preferences.dart';
import 'package:shantika_agen/features/profile/personal%20information/cubit/personal_info_cubit.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/typography.dart';

import '../../../ui/shared_widget/show_toast.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  String get agencyName => UserPreferences.userName ?? "JEPARA";
  String get email => UserPreferences.userEmail ?? "-";
  String get phone => UserPreferences.userPhone ?? "-";
  String get gender => _getGenderDisplay(UserPreferences.userGender);
  String get address => UserPreferences.userAddress ?? "-";
  String? get avatarUrl => UserPreferences.userPhoto;

  @override
  void initState() {
    super.initState();
    context.read<PersonalInfoCubit>().getProfile();
  }

  String _getGenderDisplay(String? gender) {
    if (gender == null || gender.isEmpty) return "-";
    if (gender.toLowerCase() == "male" || gender.toLowerCase() == "m") return "Pria";
    if (gender.toLowerCase() == "female" || gender.toLowerCase() == "f") return "Wanita";
    return gender;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInfoCubit, PersonalInfoState>(
      listener: (context, state) {
        if (state is PersonalInfoSuccess) {
          CustomToast.showSuccess(context, 'Foto profil berhasil diupdate!');
          setState(() {
            _selectedImage = null;
          });
        } else if (state is PersonalInfoError) {
          CustomToast.showError(context, state.message);
          setState(() {
            _selectedImage = null;
          });
        } else if (state is ProfileRefreshed) {
          setState(() {});
        }
      },
      child: Scaffold(
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
        body: Stack(
          children: [
            BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
              builder: (context, state) {
                if (state is PersonalInfoLoading && _selectedImage == null) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  );
                }

                return SingleChildScrollView(
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
                          value: email,
                        ),
                        SizedBox(height: spacing6),
                        _buildTextField(
                          label: "Nomor Telepon",
                          value: phone,
                        ),
                        SizedBox(height: spacing6),
                        _buildTextField(
                          label: "Jenis Kelamin",
                          value: gender,
                        ),
                        SizedBox(height: spacing6),
                        _buildTextField(
                          label: "Alamat Lengkap",
                          value: address,
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
              builder: (context, state) {
                if (state is PersonalInfoLoading && _selectedImage != null) {
                  return Container(
                    color: Colors.black54,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Mengupload foto...',
                            style: smRegular.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
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
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!) as ImageProvider
                  : (avatarUrl != null && avatarUrl!.isNotEmpty
                  ? NetworkImage(avatarUrl!)
                  : AssetImage('assets/images/img_eunsoo.jpeg')
              as ImageProvider),
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
                    child: SvgPicture.asset(
                        'assets/icons/ic_camera_outline.svg'),
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
                agencyName,
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
                        _pickImage(ImageSource.camera);
                      },
                    ),
                    _buildImageOption(
                      context: context,
                      bottomSheetContext: dialogContext,
                      icon: Icons.image,
                      label: 'Galeri',
                      onTap: () {
                        Navigator.pop(dialogContext);
                        _pickImage(ImageSource.gallery);
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

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });

        _showUploadConfirmation();
      }
    } catch (e) {
      print('❌ Error picking image: $e');
      CustomToast.showError(context, 'Gagal memilih gambar');
    }
  }

  void _showUploadConfirmation() {
    showDialog(
      context: context,
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
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: blue400.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(borderRadius500),
                  ),
                  child: Icon(Icons.cloud_upload, color: blue400, size: iconL),
                ),
                SizedBox(height: spacing5),
                Text("Upload Foto Profil", style: mdSemiBold),
                SizedBox(height: space200),
                Text(
                  "Apakah Anda yakin ingin mengubah foto profil?",
                  style: smRegular.copyWith(color: black700_70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: spacing6),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedImage = null;
                          });
                          Navigator.pop(dialogContext);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: paddingS),
                          backgroundColor: black00,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(borderRadius300),
                            side: BorderSide(color: black700_70),
                          ),
                        ),
                        child: Text(
                          'Batal',
                          style: mdMedium.copyWith(color: black950),
                        ),
                      ),
                    ),
                    SizedBox(width: spacing4),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          _uploadImage();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: paddingS),
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(borderRadius300),
                          ),
                        ),
                        child: Text(
                          'Upload',
                          style: mdMedium.copyWith(color: black00),
                        ),
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

  void _uploadImage() {
    if (_selectedImage == null) return;
    context.read<PersonalInfoCubit>().updateAvatar(_selectedImage!);
  }
}