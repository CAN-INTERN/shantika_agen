import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>()..init();

    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginStateSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationScreen(),
              ),
                  (route) => false,
            );
          } else if (state is LoginStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.message}'),
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
              child: Form(
                key: _formKey,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selamat Datang',
              style: mlBold.copyWith(color: textDarkPrimary),
            ),
            Text(
              'di Aplikasi Agen New Shantika',
              style: mlBold.copyWith(color: textDarkPrimary),
            ),
            SizedBox(height: padding20),

            // Google Login Button
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
                    print('🔍 Google login button pressed');
                    try {
                      // LANGSUNG NAVIGATE KE NAVIGATION SCREEN AJG
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationScreen(),
                        ),
                            (route) => false,
                      );
                    } catch (e) {
                      print('❌ Error navigating: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                          backgroundColor: red600,
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(borderRadius300),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: smRegular.fontSize!,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/ic_google.svg'),
                        SizedBox(width: spacing2 * 2),
                        Text(
                          'masuk dengan google',
                          style: smSemiBold.copyWith(
                            color: textDarkPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: padding16),

            // Register Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'belum punya akun? ',
                  style: smRegular.copyWith(color: textDarkSecondary),
                ),
                SizedBox(width: space100),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Fitur registrasi belum tersedia'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Text(
                    'Daftar',
                    style: smBold.copyWith(color: primaryColor),
                  ),
                ),
                SizedBox(width: space100),
                Text(
                  ' sekarang',
                  style: smRegular.copyWith(color: textDarkSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}