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
  String? selectedBank;
  final TextEditingController nominalController = TextEditingController();

  List<Map<String, TextEditingController>> additionalDeposits = [];

  final List<String> paymentMethods = [
    'Transfer Bank',
    'Titip Crew',
  ];

  final List<Map<String, dynamic>> bankList = [
    {'name': 'BCA', 'icon': Icons.account_balance},
    {'name': 'Mandiri', 'icon': Icons.account_balance},
    {'name': 'BRI', 'icon': Icons.account_balance},
    {'name': 'BNI', 'icon': Icons.account_balance},
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
                  if (selectedMethod == 'Transfer Bank') ...[
                    _buildArmadaSection(),
                    const SizedBox(height: 24),
                  ],
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
    bool isTransferBank = method == 'Transfer Bank';

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedMethod = method;
              if (!isTransferBank) {
                selectedBank = null;
              }
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
                Row(
                  children: [
                    if (isSelected && !isTransferBank)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: jacarta900,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: black00,
                          size: 14,
                        ),
                      ),
                    if (isTransferBank) ...[
                      if (isSelected && selectedBank != null)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: jacarta900,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: black00,
                            size: 14,
                          ),
                        ),
                      Icon(
                        isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: jacarta900,
                        size: 24,
                      ),
                    ],
                    if (!isSelected && !isTransferBank)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE8E8E8)),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Bank selection dropdown for Transfer Bank
        if (isTransferBank && isSelected)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: bankList.map((bank) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBank = bank['name'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedBank == bank['name']
                          ? jacarta900.withOpacity(0.05)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          bank['icon'],
                          color: textDisabled,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          bank['name'],
                          style: mdRegular.copyWith(
                            color: selectedBank == bank['name']
                                ? jacarta900
                                : black950,
                            fontWeight: selectedBank == bank['name']
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
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
                style: mdRegular.copyWith(color: textNeutralSecondary),
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
          titleSection: 'Nominal',
          hintColor: textDisabled,
          titleStyle: mdRegular.copyWith(color: black950),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              _showSetoranTambahanBottomSheet();
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
                  style: mdSemiBold.copyWith(color: jacarta900),
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

  void _showSetoranTambahanBottomSheet() {
    List<Map<String, TextEditingController>> tempDeposits =
    additionalDeposits.map((deposit) {
      return {
        'keterangan': TextEditingController(text: deposit['keterangan']!.text),
        'nominal': TextEditingController(text: deposit['nominal']!.text),
      };
    }).toList();

    if (tempDeposits.isEmpty) {
      tempDeposits.add({
        'keterangan': TextEditingController(),
        'nominal': TextEditingController(),
      });
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: BoxDecoration(
                color: black00,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 20),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(tempDeposits.length, (index) {
                            return _buildDepositItem(
                              index: index,
                              tempDeposits: tempDeposits,
                              setModalState: setModalState,
                            );
                          }),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            onPressed: () {
                              setModalState(() {
                                tempDeposits.add({
                                  'keterangan': TextEditingController(),
                                  'nominal': TextEditingController(),
                                });
                              });
                            },
                            icon: Icon(Icons.add, color: jacarta900),
                            label: Text(
                              'Setoran Tambahan',
                              style: mdMedium.copyWith(color: jacarta900),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 48),
                              side: BorderSide(color: jacarta900),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              onPressed: () {
                                for (var deposit in additionalDeposits) {
                                  deposit['keterangan']?.dispose();
                                  deposit['nominal']?.dispose();
                                }
                                setState(() {
                                  additionalDeposits = tempDeposits;
                                });
                                Navigator.pop(context);
                              },
                              backgroundColor: jacarta900,
                              borderRadius: 8,
                              height: 48,
                              child: Text(
                                'Simpan',
                                style: mdSemiBold.copyWith(color: black00),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      if (tempDeposits != additionalDeposits) {
        for (var deposit in tempDeposits) {
          deposit['keterangan']?.dispose();
          deposit['nominal']?.dispose();
        }
      }
    });
  }

  Widget _buildDepositItem({
    required int index,
    required List<Map<String, TextEditingController>> tempDeposits,
    required StateSetter setModalState,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Setoran Tambahan ${index + 1}',
            style: mdSemiBold.copyWith(color: black950),
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: tempDeposits[index]['keterangan']!,
            maxLines: 1,
            placeholder: '',
            titleSection: 'Keterangan',
            hintColor: textDisabled,
            titleStyle: smRegular.copyWith(color: black950),
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: tempDeposits[index]['nominal']!,
            keyboardType: TextInputType.number,
            maxLines: 1,
            titleSection: 'Nominal',
            hintColor: textDisabled,
            titleStyle: smRegular.copyWith(color: black950),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                setModalState(() {
                  tempDeposits[index]['keterangan']?.dispose();
                  tempDeposits[index]['nominal']?.dispose();
                  tempDeposits.removeAt(index);
                });
              },
              icon: Icon(Icons.delete, color: errorColor, size: 20),
              label: Text(
                'Hapus',
                style: mdMedium.copyWith(color: errorColor),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
    for (var deposit in additionalDeposits) {
      deposit['keterangan']?.dispose();
      deposit['nominal']?.dispose();
    }
    super.dispose();
  }
}
