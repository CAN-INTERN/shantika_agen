import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:shantika_agen/features/deposit/bus_screen.dart';
import 'package:shantika_agen/features/deposit/deposit_history_screen.dart';
import 'package:shantika_agen/features/deposit/finance_screen.dart';
import 'package:shantika_agen/features/deposit/seat_screen.dart';
import 'package:shantika_agen/features/deposit/ticket_sales_screen.dart';
import 'package:shantika_agen/features/deposit/total_expenses_screen.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/shared_widget/custom_button.dart';
import 'package:shantika_agen/ui/typography.dart';
import '../../ui/shared_widget/custom_arrow.dart';
import '../../ui/shared_widget/custom_input_bottom_sheet.dart';
import 'deposit_screen.dart';

class DepositDetailScreen extends StatelessWidget {
  const DepositDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDeposit,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildInfoCard(),
                  _buildOperationalCard(context),
                  _buildWhiteSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return CustomArrow(
      title: "Detail Setoran",
      titleStyle: xlBold.copyWith(color: black00),
      iconColor: black00,
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        'Tagihan harus dibayarkan setiap harinya, dan komisi akan diberikan kantor jika pembayaran tagihan sudah dilakukan. Pastikan pembayaran tagihan sudah sesuai dengan aplikasi',
        style: xsRegular.copyWith(color: jacarta800),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildOperationalCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 16, bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Transform.translate(
            offset: Offset(-18, 20),
            child: Image.asset(
              'assets/images/img_operational_agent.png',
              height: 160,
              fit: BoxFit.contain,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pengeluaran\nOperasional Agen',
                    style: lgBold.copyWith(color: black00)),
                SizedBox(height: 8),
                Text(
                    'Catat pengeluaran tambahan yang terjadi di Agen anda dan hubungi PO New Shantika',
                    style: xsRegular.copyWith(color: black00)),
                SizedBox(height: 12),
                CustomButton(
                    onPressed: () => _showAddExpenseBottomSheet(context),
                    backgroundColor: black950,
                    height: 35,
                    width: 145,
                    child: Text(
                      'Tambah Pengeluaran',
                      style: xsMedium.copyWith(color: black00),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteSection(BuildContext context) {
    return Transform.translate(
        offset: Offset(0, 20),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 35, left: 20, right: 20, bottom: 20),
          decoration: BoxDecoration(
            color: black00,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Detail Setoran 24 Desember 2025', style: mdBold),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinanceScreen(),
                        ),
                      ),
                      icon: Icons.wallet,
                      iconColor: bgDeposit,
                      label: 'Total Setoran',
                      amount: 'Rp0',
                      amountColor: black00,
                      hasArrow: true,
                      backgroundColor: bgDeposit,
                      borderRadius: 8,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildDetailItem(
                        icon: Icons.attach_money,
                        iconColor: Color(0xFF4CAF50),
                        label: 'Komisi',
                        amount: 'Rp0',
                        amountColor: jacarta800,
                        hasArrow: false,
                        backgroundColor: black00,
                        borderRadius: 8),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TicketSalesScreen(),
                              ),
                            ),
                        icon: Icons.receipt,
                        iconColor: Color(0xFFFFC107),
                        label: 'Penjualan Tiket',
                        amount: 'Rp0',
                        amountColor: jacarta800,
                        hasArrow: true,
                        backgroundColor: black00,
                        borderColor: bgDeposit),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildDetailItem(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TotalExpensesScreen(),
                        ),
                      ),
                      icon: Icons.point_of_sale,
                      iconColor: Color(0xFFF44336),
                      label: 'Total Pengeluaran',
                      amount: 'Rp0',
                      amountColor: Color(0xFFF44336),
                      hasArrow: true,
                      backgroundColor: black00,
                      borderColor: bgDeposit,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusScreen(),
                              ),
                            ),
                        icon: Icons.directions_bus,
                        iconColor: Color(0xFF00BCD4),
                        label: 'Bus dipesan',
                        amount: '0',
                        amountColor: jacarta800,
                        hasArrow: true,
                        backgroundColor: black00,
                        borderColor: bgDeposit),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildDetailItem(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeatScreen(),
                              ),
                            ),
                        icon: Icons.airline_seat_recline_normal,
                        iconColor: Color(0xFF9C27B0),
                        label: 'Kursi dipesan',
                        amount: '0 kursi',
                        amountColor: jacarta800,
                        hasArrow: true,
                        backgroundColor: black00,
                        borderColor: bgDeposit),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text('Setoran Setelah Pengeluaran', style: mdBold),
              SizedBox(height: 16),
              CustomPaint(
                painter: DashedBorderPainter(
                  color: textDisabled,
                  strokeWidth: 1.5,
                  dashWidth: 5,
                  dashSpace: 3,
                  borderRadius: 12,
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: black00,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildSetoranRow('Setoran Awal', 'Rp0', false),
                      SizedBox(
                        height: 8,
                      ),
                      _buildSetoranRow('Pengeluaran', 'Rp0', true),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(color: textDisabled, height: 1),
                      ),
                      _buildSetoranRow('Total Setoran', 'Rp0', false,
                          isBold: true),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              _buildBottomButtons(context),
              SizedBox(height: 16),
            ],
          ),
        ));
  }

  Widget _buildDetailItem({
    IconData? icon,
    String? svgPath,
    required Color iconColor,
    required String label,
    required String amount,
    required Color amountColor,
    required bool hasArrow,
    required Color backgroundColor,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = 12.0,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor != null
              ? Border.all(color: borderColor, width: borderWidth)
              : (backgroundColor == black00
                  ? Border.all(color: Color(0xFFE8E8E8))
                  : null),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: backgroundColor == bgDeposit
                        ? black00.withOpacity(0.3)
                        : iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: svgPath != null
                      ? SvgPicture.asset(
                          svgPath,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            backgroundColor == bgDeposit ? black00 : iconColor,
                            BlendMode.srcIn,
                          ),
                        )
                      : Icon(
                          icon ?? Icons.help_outline,
                          color: backgroundColor == bgDeposit
                              ? black00
                              : iconColor,
                          size: 20,
                        ),
                ),
                if (hasArrow)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: backgroundColor == bgDeposit ? black00 : bgDeposit,
                  ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              label,
              style: xxsRegular.copyWith(
                  color: backgroundColor == bgDeposit
                      ? black00.withOpacity(0.7)
                      : Colors.grey[600]),
            ),
            SizedBox(height: 4),
            Text(
              amount,
              style: mdBold.copyWith(color: amountColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetoranRow(String label, String amount, bool isRed,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: xsRegular.copyWith(
            color: black950,
          ),
        ),
        Text(
          amount,
          style: xsRegular.copyWith(
            color: isRed ? errorColor : black950,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DepositHistoryScreen(),
                ),
              );
            },
            backgroundColor: Colors.transparent,
            height: 40,
            boxShadow: [],
            borderRadius: 8,
            borderColor: jacarta900,
            child: Text(
              'Riwayat',
              style: smSemiBold.copyWith(color: jacarta900),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: CustomButton(
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
            height: 40,
            child: Text(
              'Setorkan',
              style: smSemiBold.copyWith(color: black00),
            ),
          ),
        ),
      ],
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
