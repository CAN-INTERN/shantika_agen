import 'package:flutter/material.dart';
import 'package:shantika_agen/features/deposit/deposit_screen.dart';
import 'package:shantika_agen/features/deposit/ticket_sales_screen.dart';
import 'package:shantika_agen/ui/color.dart';
import '../../ui/shared_widget/custom_arrow.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_input_bottom_sheet.dart';
import '../../ui/typography.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  _buildDate(),
                  SizedBox(height: 24),
                  _buildTotalSetoran(),
                  SizedBox(height: 24),
                  _buildTotalSetoranArmada(context),
                  SizedBox(height: 20),
                  _buildSetoranCard(),
                ],
              ),
            ),
          ),
          _buildBottomButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return CustomArrow(title: "Keuangan");
  }

  Widget _buildDate() {
    return Text(
      'Tanggal 24, Desember 2025',
      style: smRegular.copyWith(color: jacarta900),
    );
  }

  Widget _buildTotalSetoran() {
    return Column(
      children: [
        Text(
          'Total Setoran Agen',
          style: smRegular.copyWith(color: textDisabled),
        ),
        SizedBox(height: 8),
        Text(
          'Rp0',
          style: xxlBold.copyWith(color: bgDeposit),
        ),
      ],
    );
  }

  Widget _buildTotalSetoranArmada(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketSalesScreen(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Setoran Armada',
              style: mdRegular.copyWith(color: black950),
            ),
            Row(
              children: [
                Text(
                  'Rp0',
                  style: mdSemiBold.copyWith(color: black950),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: black950,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSetoranCard() {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: Color(0xFFD1D5DB),
        strokeWidth: 1.5,
        dashWidth: 5,
        dashSpace: 3,
        borderRadius: 12,
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: black00,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildSetoranRow('Setoran Armada', 'Rp0', false),
            SizedBox(height: 16),
            _buildSetoranRow('Pengeluaran', 'Rp0', true),
            SizedBox(height: 16),
            Divider(color: Color(0xFFE5E7EB), height: 1),
            SizedBox(height: 16),
            _buildSetoranRow('Total Setoran', 'Rp0', false, isBold: true, isBlue: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSetoranRow(String label, String amount, bool isRed, {bool isBold = false, bool isBlue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: (isBold ? mdSemiBold : mdRegular).copyWith(
            color: black950,
          ),
        ),
        Text(
          amount,
          style: (isBold ? mdSemiBold : mdRegular).copyWith(
            color: isRed
                ? errorColor
                : isBlue
                ? jacarta900
                : black950,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DepositScreen(),
                ),
              );
            },
            backgroundColor: jacarta900,
            borderRadius: 8,
            height: 48,
            child: Text(
              'Setorkan',
              style: mdSemiBold.copyWith(color: black00),
            ),
          ),
          SizedBox(height: 12),
          CustomButton(
            onPressed: () => _showAddExpenseBottomSheet(context),
            backgroundColor: Colors.transparent,
            height: 48,
            boxShadow: [],
            borderRadius: 8,
            borderColor: jacarta900,
            child: Text(
              'Tambah Pengeluaran',
              style: mdSemiBold.copyWith(color: jacarta900),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final dashPath = _createDashedPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final dashedPath = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final nextDistance = distance + dashWidth;
        final extractPath = metric.extractPath(
          distance,
          nextDistance > metric.length ? metric.length : nextDistance,
        );
        dashedPath.addPath(extractPath, Offset.zero);
        distance = nextDistance + dashSpace;
      }
    }
    return dashedPath;
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.borderRadius != borderRadius;
  }
}
void _showAddExpenseBottomSheet(BuildContext context) {
  final expenseTypeController = TextEditingController();
  final amountController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: black00,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => CustomInputBottomSheet(
      expenseTypeController: expenseTypeController,
      amountController: amountController,
      onSubmit: () {
        if (expenseTypeController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mohon isi jenis pengeluaran')),
          );
          return;
        }

        if (amountController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mohon isi total pengeluaran')),
          );
          return;
        }

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pengeluaran berhasil ditambahkan'),
            backgroundColor: Colors.green,
          ),
        );
      },
    ),
  );
}
