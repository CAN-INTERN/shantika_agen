import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_agen/features/profile/privacy_policy/cubit/privacy_policy_cubit.dart';
import 'package:shantika_agen/features/profile/privacy_policy/cubit/privacy_policy_state.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/typography.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PrivacyPolicyCubit>().fetchPrivacyPolicy();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await context.read<PrivacyPolicyCubit>().fetchPrivacyPolicy();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
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
          "Kebijakan Privasi",
          style: xlBold,
        ),
      ),
      body: BlocBuilder<PrivacyPolicyCubit, PrivacyPolicyState>(
        builder: (context, state) {
          if (state is PrivacyPolicyLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: blue600,
              ),
            );
          }

          if (state is PrivacyPolicyError) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: blue600,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: red600,
                        ),
                        SizedBox(height: spacing5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: space800),
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: smMedium,
                          ),
                        ),
                        SizedBox(height: space600),
                        ElevatedButton(
                          onPressed: () {
                            context.read<PrivacyPolicyCubit>().fetchPrivacyPolicy();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue600,
                            foregroundColor: black00,
                            padding: EdgeInsets.symmetric(
                              horizontal: space800,
                              vertical: padding12,
                            ),
                          ),
                          child: Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          if (state is PrivacyPolicyLoaded) {
            final policy = state.privacyPolicy;

            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: blue600,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(padding20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          policy.name,
                          style: mdBold,
                        ),
                        SizedBox(height: spacing5),
                        _buildHtmlContent(policy.content),
                        SizedBox(height: space600),
                        Text(
                          "Terakhir diperbarui: ${_formatDate(policy.updatedAt)}",
                          style: xsMedium.copyWith(color: black700_70),
                        ),
                        SizedBox(height: space2000),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: AnimatedBuilder(
                    animation: _scrollController,
                    builder: (context, child) {
                      final showButton = _scrollController.hasClients &&
                          _scrollController.offset > 200;

                      return AnimatedOpacity(
                        opacity: showButton ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 200),
                        child: AnimatedScale(
                          scale: showButton ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 200),
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: blue600,
                            foregroundColor: black00,
                            onPressed: showButton ? _scrollToTop : null,
                            child: Icon(Icons.arrow_upward),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHtmlContent(String htmlContent) {
    String cleanContent = htmlContent
        .replaceAll(RegExp(r'<br\s*/?>'), '\n')
        .replaceAll(RegExp(r'<p>'), '\n')
        .replaceAll(RegExp(r'</p>'), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .trim();

    return Text(
      cleanContent,
      style: smMedium,
      textAlign: TextAlign.justify,
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];

    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }
}