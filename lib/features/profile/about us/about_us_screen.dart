import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/typography.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cubit/about_us_cubit.dart';
import 'cubit/about_us_state.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AboutUsCubit>().fetchAboutUs();
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tidak dapat membuka link')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

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
          "Tentang Kami",
          style: xlBold,
        ),
      ),
      body: BlocBuilder<AboutUsCubit, AboutUsState>(
        builder: (context, state) {
          if (state is AboutUsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AboutUsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: red600,
                  ),
                  SizedBox(height: spacing5),
                  Text(
                    state.message,
                    style: smMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: space600),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AboutUsCubit>().fetchAboutUs();
                    },
                    child: Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (state is AboutUsLoaded) {
            final about = state.about;

            return RefreshIndicator(
              onRefresh: () => context.read<AboutUsCubit>().refreshAboutUs(),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(padding20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: space600),
                      Text(
                        "Agen 2.0",
                        style: xlBold,
                      ),
                      SizedBox(height: space1000),
                      Image.network(
                        about.image,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: black300,
                            child: Center(
                              child: Icon(
                                Icons.directions_bus,
                                size: 80,
                                color: black300,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200,
                            color: black300,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: space600),
                      if (about.description.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: padding16),
                          child: Text(
                            about.description,
                            style: smMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      SizedBox(height: space1000),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _socialMediaButton(
                            svgAsset: 'assets/icons/ic_instagram.svg',
                            onTap: () => _launchUrl('https://instagram.com'),
                          ),
                          SizedBox(width: space1200),
                          _socialMediaButton(
                            svgAsset: 'assets/icons/ic_email.svg',
                            onTap: () => _launchUrl('mailto:info@newshantika.com'),
                          ),
                          SizedBox(width: space1200),
                          _socialMediaButton(
                            svgAsset: 'assets/icons/ic_facebook.svg',
                            onTap: () => _launchUrl('https://newshantika.com'),
                          ),
                        ],
                      ),
                      SizedBox(height: space600),
                      Text(
                        about.address,
                        style: mdMedium.copyWith(color: black750),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(
            child: Text('Tidak ada data'),
          );
        },
      ),
    );
  }

  Widget _socialMediaButton({
    required String svgAsset,
    required VoidCallback onTap
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius300),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: black950.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            svgAsset,
            width: iconL,
            height: iconL,
            colorFilter: ColorFilter.mode(black00, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}