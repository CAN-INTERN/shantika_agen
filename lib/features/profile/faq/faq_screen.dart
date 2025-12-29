import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/typography.dart';
import 'cubit/faq_cubit.dart';
import 'cubit/faq_state.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FaqCubit>().fetchFaqs();
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
          "FAQ",
          style: xlBold,
        ),
      ),
      body: BlocBuilder<FaqCubit, FaqState>(
        builder: (context, state) {
          if (state is FaqLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FaqError) {
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: space800),
                    child: Text(
                      state.message,
                      style: smMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: space600),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FaqCubit>().fetchFaqs();
                    },
                    child: Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (state is FaqLoaded) {
            if (state.faqs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: iconXL,
                      color: black700_70,
                    ),
                    SizedBox(height: spacing5),
                    Text(
                      'Tidak ada FAQ',
                      style: mdMedium,
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<FaqCubit>().refreshFaqs(),
              child: ListView.builder(
                padding: EdgeInsets.all(padding16),
                itemCount: state.faqs.length,
                itemBuilder: (context, index) {
                  final faq = state.faqs[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == state.faqs.length - 1 ? 0 : padding16,
                    ),
                    child: _buildFaqItem(
                      question: faq.question,
                      answer: faq.answer,
                    ),
                  );
                },
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

  Widget _buildFaqItem({
    required String question,
    required String answer,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(borderRadius300),
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: padding20, vertical: paddingS),
          childrenPadding: EdgeInsets.only(
            left: padding20,
            right: padding20,
            bottom: padding20,
            top: 0,
          ),
          title: Text(
            question,
            style: smMedium.copyWith(color: black00),
          ),
          iconColor: black00,
          collapsedIconColor: black00,
          children: [
            Text(
              answer,
              style: smMedium.copyWith(color: black00),
            ),
          ],
        ),
      ),
    );
  }
}