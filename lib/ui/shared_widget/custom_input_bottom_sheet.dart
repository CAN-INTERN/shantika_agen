import 'package:flutter/material.dart';

import '../color.dart';
import '../typography.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';

class CustomInputBottomSheet extends StatelessWidget {
  final TextEditingController expenseTypeController;
  final TextEditingController amountController;
  final VoidCallback onSubmit;
  final bool isLoading;

  const CustomInputBottomSheet({
    super.key,
    required this.expenseTypeController,
    required this.amountController,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: IntrinsicHeight(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: bgSurfaceNeutralDark,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                Container(
                  height: 150,
                  child: Image.asset(
                    'assets/images/img_success_illustration.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: expenseTypeController,
                  maxLines: 1,
                  placeholder: 'Ganti Wiper Depan Patah BARXOLID K 3123...',
                  hintColor: black500,
                  titleSection: 'Jenis Pengeluaran',
                  titleStyle: smRegular.copyWith(color: black950),
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: amountController,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  placeholder: 'Rp 0',
                  hintColor: black500,
                  titleSection: 'Total Pengeluaran',
                  titleStyle: smRegular.copyWith(color: black950),
                ),
                SizedBox(height: 24),

                CustomButton(
                  onPressed: onSubmit,
                  backgroundColor: jacarta900,
                  width: double.infinity,
                  height: 45,
                  child: Text(
                    'Tambah Pengeluaran',
                    style: mdMedium.copyWith(color: black00),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
