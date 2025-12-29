import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_agen/features/navigation/navigation_screen.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/typography.dart';
import '../../ui/dimension.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String _formatPhoneNumber(String phone) {
    phone = phone.replaceAll(RegExp(r'\D'), '');
    if (phone.startsWith('0')) {
      return '+62${phone.substring(1)}';
    } else if (phone.startsWith('62')) {
      return '+$phone';
    } else if (phone.startsWith('+62')) {
      return phone;
    }
    return '+62$phone';
  }

  void _loginWithPhone(LoginCubit cubit) {
    if (_formKey.currentState!.validate()) {
      final phone = _formatPhoneNumber(_phoneController.text);
      print('📱 Login with phone: $phone');
      cubit.loginWithPhone(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>()..init();

    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginStateSuccess) {
            print('✅ Login success, navigating to home...');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationScreen(),
              ),
                  (route) => false,
            );
          } else if (state is LoginStateError) {
            print('❌ Login error: ${state.message}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: red600,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Stack(
          children: [
            _buildBackgroundImage(),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildLogoSection(),
                  ),
                  Expanded(
                    flex: 3,
                    child: _buildLoginFormSection(context, loginCubit),
                  ),
                ],
              ),
            ),

            // Loading Overlay
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state is LoginStateLoading) {
                  return Container(
                    color: Colors.black54,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              primaryColor,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Sedang login...',
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

  Widget _buildBackgroundImage() {
    return Container(
      height: 426,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/img_banner_shantika.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            secondaryColor_60,
            BlendMode.darken,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Center(
      child: Image.asset(
        'assets/images/ic_logo_shantika_agen.png',
        width: 230,
        height: 150,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildLoginFormSection(BuildContext context, LoginCubit loginCubit) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius750),
          topRight: Radius.circular(borderRadius750),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: paddingXL,
          left: padding20,
          right: padding20,
          bottom: padding16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Selamat Datang',
                style: mBold.copyWith(color: textDarkPrimary),
              ),
              Text(
                'di Aplikasi Agen New Shantika',
                style: mBold.copyWith(color: textDarkPrimary),
              ),
              SizedBox(height: padding20),

              // ✅ Phone Login TextField (NEW)
              Text(
                'Nomor HP',
                style: smBold.copyWith(color: textDarkPrimary),
              ),
              SizedBox(height: padding6),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(13),
                ],
                style: mdRegular.copyWith(color: textDarkPrimary),
                decoration: InputDecoration(
                  hintText: '8123456789',
                  hintStyle: mdRegular.copyWith(color: textDisabled),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: padding12, right: padding6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '+62',
                          style: mdRegular.copyWith(color: textDarkPrimary),
                        ),
                        SizedBox(width: padding6),
                        Container(
                          width: 1,
                          height: 20,
                          color: textDisabled,
                        ),
                      ],
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: padding16,
                    vertical: padding12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius300),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius300),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius300),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius300),
                    borderSide: BorderSide(color: red600),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP tidak boleh kosong';
                  }
                  if (value.length < 9) {
                    return 'Nomor HP minimal 9 digit';
                  }
                  if (!value.startsWith('8') && !value.startsWith('0')) {
                    return 'Format nomor HP tidak valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: padding16),

              // ✅ Phone Login Button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius300),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () => _loginWithPhone(loginCubit),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: padding16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius300),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Masuk dengan Nomor HP',
                    style: mdBold.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: padding16),

              // ✅ Divider "atau"
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: textDisabled,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding12),
                    child: Text(
                      'atau',
                      style: smRegular.copyWith(color: textDisabled),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: textDisabled,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: padding16),

              // ✅ Google Login Button
              Container(
                decoration: BoxDecoration(
                  color: bgButtonOutlinedDefault,
                  borderRadius: BorderRadius.circular(borderRadius300),
                  boxShadow: [
                    BoxShadow(
                      color: black950.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print('🔐 Login dengan Google');
                      loginCubit.loginWithGoogle();
                    },
                    borderRadius: BorderRadius.circular(borderRadius300),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: smRegular.fontSize!,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/ic_google.svg',
                            width: iconL,
                          ),
                          SizedBox(width: spacing2 * 2),
                          Text(
                            'Masuk Dengan Google',
                            style: mdRegular.copyWith(
                              color: textDarkPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}