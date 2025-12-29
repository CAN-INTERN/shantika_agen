import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/typography.dart';
import 'cubit/terms_condition_cubit.dart';
import 'cubit/terms_condition_state.dart';

class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({super.key});

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TermsConditionCubit>().fetchTermsCondition();
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
          "Syarat Dan Ketentuan",
          style: xlBold,
        ),
      ),
      body: BlocBuilder<TermsConditionCubit, TermsConditionState>(
        builder: (context, state) {
          if (state is TermsConditionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TermsConditionError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: red600,
                    ),
                    SizedBox(height: padding16),
                    Text(
                      state.message,
                      style: smMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: space600),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<TermsConditionCubit>().fetchTermsCondition();
                      },
                      icon: Icon(Icons.refresh),
                      label: Text('Coba Lagi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: black700_70,
                        foregroundColor: black00,
                        padding: EdgeInsets.symmetric(
                          horizontal: paddingL,
                          vertical: padding12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is TermsConditionLoaded) {
            final data = state.termsCondition;

            return RefreshIndicator(
              onRefresh: () =>
                  context.read<TermsConditionCubit>().refreshTermsCondition(),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(padding20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: smMedium,
                    ),
                    SizedBox(height: 20),
                    HtmlWidget(
                      data.content,
                      customStylesBuilder: (element) {
                        if (element.localName == 'h1') {
                          return {
                            'color': '#000000',
                            'font-size': '18px',
                            'font-weight': '700',
                            'margin-bottom': '16px',
                            'text-align': 'center',
                          };
                        }
                        if (element.localName == 'h2') {
                          return {
                            'color': '#000000',
                            'font-size': '17px',
                            'font-weight': '700',
                            'margin-top': '24px',
                            'margin-bottom': '16px',
                          };
                        }
                        if (element.localName == 'p') {
                          return {
                            'color': '#000000DD',
                            'font-size': '14px',
                            'line-height': '1.6',
                            'text-align': 'justify',
                            'margin-bottom': '16px',
                          };
                        }
                        if (element.localName == 'ul' || element.localName == 'ol') {
                          return {
                            'margin-left': '20px',
                            'margin-bottom': '16px',
                          };
                        }
                        if (element.localName == 'li') {
                          return {
                            'color': '#000000DD',
                            'font-size': '14px',
                            'line-height': '1.6',
                            'margin-bottom': '8px',
                          };
                        }
                        return null;
                      },
                      textStyle: mdMedium,
                    ),

                    SizedBox(height: space600),
                    Text(
                      'Terakhir diperbarui: ${_formatDate(data.updatedAt)}',
                      style: xsMedium.copyWith(color: black700_70),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: Text('Tidak ada data'),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}