import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import '../../ui/shared_widget/custom_arrow.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_text_form_field.dart';
import '../../ui/typography.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  String selectedMethod = 'Transfer Bank';
  String? selectedArmada;
  final TextEditingController nominalController = TextEditingController();

  final List<String> paymentMethods = [
    'Transfer Bank',
    'Titip Crew',
  ];

  final List<String> armadaList = [
    'Armada 1',
    'Armada 2',
    'Armada 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildTotalDeposit(),
                  const SizedBox(height: 32),
                  _buildPaymentMethodSection(),
                  const SizedBox(height: 24),
                  _buildArmadaSection(),
                  const SizedBox(height: 24),
                  _buildNominalSection(),
                  const SizedBox(height: 32),
                  _buildSetoranTambahan(),
                ],
              ),
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return CustomArrow(title: "Setorkan");
  }

  Widget _buildTotalDeposit() {
    return Center(
      child: Column(
        children: [
          Text(
            'Total Setoran',
            style: smRegular.copyWith(color: textDisabled),
          ),
          const SizedBox(height: 8),
          Text(
            'Rp0',
            style: xxlBold.copyWith(color: jacarta900),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Metode Setoran',
          style: mdRegular.copyWith(color: black950),
        ),
        const SizedBox(height: 12),
        ...paymentMethods.map((method) => _buildMethodOption(method)),
      ],
    );
  }

  Widget _buildMethodOption(String method) {
    bool isSelected = selectedMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: black00,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? jacarta900 : const Color(0xFFE8E8E8),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              method,
              style: mdRegular.copyWith(color: black950),
            ),
            if (isSelected)
            // Untuk Transfer Bank, gunakan arrow dropdown
              if (method == 'Transfer Bank')
                Icon(
                  Icons.keyboard_arrow_down,
                  color: jacarta900,
                  size: 24,
                )
              else
              // Untuk Titip Crew, tetap pakai circle check
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: jacarta900,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: black00,
                    size: 16,
                  ),
                )
            else
              if (method == 'Transfer Bank')
                Icon(
                  Icons.keyboard_arrow_down,
                  color: jacarta900,
                  size: 24,
                )
              else
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                    shape: BoxShape.circle,
                  ),
                ),
          ],
        ),
      ),
    );
  }
  Widget _buildArmadaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Armada',
          style: mdRegular.copyWith(color: black950),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: black00,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8E8E8)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedArmada,
              hint: Text(
                'Pilih Armada',
                style: mdRegular.copyWith(color: textDisabled),
              ),
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: black950),
              items: armadaList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: mdRegular.copyWith(color: black950),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedArmada = newValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNominalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: nominalController,
          keyboardType: TextInputType.number,
          maxLines: 1,
          placeholder: 'Rp 0',
          titleSection: 'Nominal',
          hintColor: textDisabled,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
            },
            icon: Icon(Icons.add, color: bgDeposit),
            label: Text(
              'Setoran Tambahan',
              style: mdMedium.copyWith(color: bgDeposit),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSetoranTambahan() {
    return const SizedBox.shrink();
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Total section
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: mdSemiBold.copyWith(color: black950),
                ),
                Text(
                  'Rp0',
                  style: mdSemiBold.copyWith(color: black950),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () {
                  // Handle deposit action
                },
                backgroundColor: jacarta900,
                borderRadius: 8,
                height: 48,
                child: Text(
                  'Setorkan',
                  style: mdSemiBold.copyWith(color: black00),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nominalController.dispose();
    super.dispose();
  }
}