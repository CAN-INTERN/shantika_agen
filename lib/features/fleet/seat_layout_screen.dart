import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_arrow.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/typography.dart';
import '../../utility/number_formatter.dart';

class SeatLayoutScreen extends StatefulWidget {
  const SeatLayoutScreen({super.key});

  @override
  State<SeatLayoutScreen> createState() => _SeatLayoutScreenState();
}

class _SeatLayoutScreenState extends State<SeatLayoutScreen> {
  Set<String> selectedSeats = {};
  bool isExpanded = false;
  bool isLowerSelected = true;

  final List<Map<String, dynamic>> mockLowerSeats = [
    {'name': 'CB', 'price': 206000, 'isAvailable': true},
    {'name': 'CD', 'price': 206000, 'isAvailable': true},
    {'name': '1', 'price': 206000, 'isAvailable': true},
    {'name': '2', 'price': 206000, 'isAvailable': true},
    {'name': '3', 'price': 206000, 'isAvailable': true},
    {'name': '4', 'price': 206000, 'isAvailable': true},
    {'name': '5', 'price': 206000, 'isAvailable': true},
    {'name': '6', 'price': 206000, 'isAvailable': true},
    {'name': '7', 'price': 206000, 'isAvailable': false},
    {'name': '8', 'price': 206000, 'isAvailable': true},
    {'name': '9', 'price': 206000, 'isAvailable': true},
    {'name': '10', 'price': 206000, 'isAvailable': true},
    {'name': '11', 'price': 206000, 'isAvailable': true},
    {'name': '12', 'price': 206000, 'isAvailable': true},
    {'name': '13', 'price': 206000, 'isAvailable': true},
    {'name': '14', 'price': 206000, 'isAvailable': true},
    {'name': '15', 'price': 206000, 'isAvailable': true},
    {'name': '20', 'price': 206000, 'isAvailable': true},
    {'name': '21', 'price': 206000, 'isAvailable': true},
    {'name': '22', 'price': 206000, 'isAvailable': true},
    {'name': '23', 'price': 206000, 'isAvailable': true},
    {'name': '24', 'price': 206000, 'isAvailable': true},
    {'name': '25', 'price': 206000, 'isAvailable': true},
  ];

  final List<Map<String, dynamic>> mockUpperSeats = [
    {'name': 'U1', 'price': 206000, 'isAvailable': true},
    {'name': 'U2', 'price': 206000, 'isAvailable': true},
    {'name': 'U3', 'price': 206000, 'isAvailable': false},
    {'name': 'U4', 'price': 206000, 'isAvailable': true},
  ];

  int getTotalPrice() {
    int total = 0;
    final seats = isLowerSelected ? mockLowerSeats : mockUpperSeats;
    for (var seatId in selectedSeats) {
      final seat = seats.firstWhere(
        (s) => s['name'] == seatId,
        orElse: () => {'price': 206000},
      );
      total += seat['price'] as int;
    }
    return total;
  }

  @override
  @override
  Widget build(BuildContext context) {
    final displaySeats = isLowerSelected ? mockLowerSeats : mockUpperSeats;

    return Scaffold(
      backgroundColor: bgSurfaceNeutralLight, // Changed from black00
      body: Column(
        children: [
          // Fixed header at top
          _buildHeader(),
          _buildSeatType(),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _buildSeatPlan(displaySeats),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          selectedSeats.isEmpty
              ? _buildNormalBottomButton()
              : _buildPriceBottomPanel(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(color: black00),
      child: CustomArrow(title: "Pilih Kursi"),
    );
  }

  Widget _buildSeatType() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(color: black00),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/ic_warning.svg"),
              const SizedBox(width: 8),
              Text("Tipe Kursi", style: smMedium),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _seatTypeItem(
                "assets/icons/ic_seat_unavailable.svg",
                "Tidak",
                "Tersedia",
              ),
              _seatTypeItem(
                "assets/icons/ic_seat_selected.svg",
                "Sudah",
                "Dipilih",
              ),
              _seatTypeItem(
                "assets/icons/ic_seat_regular.svg",
                "Reguler",
                "Rp206.000",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _seatTypeItem(String icon, String title, String subtitle) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: xxsRegular),
            Text(subtitle, style: xxsRegular),
          ],
        ),
      ],
    );
  }

  Widget _buildSeatPlan(List<Map<String, dynamic>> seats) {
    List<Widget> rows = [];

    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset("assets/icons/ic_door.svg"),
            SvgPicture.asset("assets/icons/ic_wheel.svg"),
          ],
        ),
      ),
    );
    rows.add(const SizedBox(height: 24));

    if (isLowerSelected) {
      rows.add(_buildManualLowerDeck(seats));
    } else {
      for (int i = 0; i < seats.length; i += 2) {
        rows.add(
          _buildUpperSeatRow(
            i < seats.length ? seats[i] : null,
            i + 1 < seats.length ? seats[i + 1] : null,
            i,
          ),
        );
        rows.add(SizedBox(height: 16));
      }
    }

    rows.add(SizedBox(height: 12));
    rows.add(
      Padding(
        padding: EdgeInsets.only(left: 0, right: 140),
        child: Row(
          children: [
            SvgPicture.asset("assets/icons/ic_door_behind.svg"),
            SizedBox(width: 12),
            SvgPicture.asset("assets/icons/ic_toilet.svg"),
          ],
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.circular(borderRadius750),
      ),
      child: Column(children: rows),
    );
  }

  Widget _buildManualLowerDeck(List<Map<String, dynamic>> seats) {
    List<Widget> rows = [];

    final cbSeat = seats.firstWhere(
      (seat) => seat['name'] == 'CB',
      orElse: () => {},
    );
    final cdSeat = seats.firstWhere(
      (seat) => seat['name'] == 'CD',
      orElse: () => {},
    );

    rows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cbSeat.isNotEmpty
              ? _buildSeatWidget(cbSeat, 0)
              : const SizedBox(width: 48),
          SizedBox(width: 16),
          cdSeat.isNotEmpty
              ? _buildSeatWidget(cdSeat, 1)
              : const SizedBox(width: 48),
          SizedBox(width: 48),
          SizedBox(width: 48),
          SizedBox(width: 48),
          SizedBox(width: 20),
        ],
      ),
    );
    rows.add(const SizedBox(height: 16));

    final numberedSeats = seats.where((seat) {
      final name = seat['name'] ?? '';
      return name != 'CB' && name != 'CD' && name.isNotEmpty;
    }).toList();

    for (int i = 0; i < numberedSeats.length; i += 4) {
      final end = (i + 4 > numberedSeats.length) ? numberedSeats.length : i + 4;
      final rowSeats = numberedSeats.sublist(i, end);

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int j = 0; j < 2; j++)
              if (j < rowSeats.length) ...[
                _buildSeatWidget(rowSeats[j], i + j),
                if (j < 1) SizedBox(width: 12),
              ] else ...[
                SizedBox(width: 48),
                if (j < 1) SizedBox(width: 12),
              ],
            SizedBox(width: 48),
            SizedBox(width: 12),
            for (int j = 2; j < 4; j++)
              if (j < rowSeats.length) ...[
                _buildSeatWidget(rowSeats[j], i + j),
                if (j < 3) SizedBox(width: 12),
              ] else ...[
                SizedBox(width: 48),
                if (j < 3) SizedBox(width: 12),
              ],
          ],
        ),
      );
      rows.add(SizedBox(height: 16));
    }

    return Column(children: rows);
  }

  Widget _buildUpperSeatRow(Map<String, dynamic>? leftSeat,
      Map<String, dynamic>? rightSeat, int startIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        leftSeat != null
            ? _buildSeatWidget(leftSeat, startIndex)
            : const SizedBox(width: 48),
        const SizedBox(width: 120),
        rightSeat != null
            ? _buildSeatWidget(rightSeat, startIndex + 1)
            : const SizedBox(width: 48),
      ],
    );
  }

  Widget _buildSeatWidget(Map<String, dynamic> seat, int index) {
    final seatId = seat['name'] ?? 'seat_$index';
    final isUnavailable = !(seat['isAvailable'] ?? true);
    final isSelected = selectedSeats.contains(seatId);

    final assetPath = isUnavailable
        ? "assets/icons/ic_seat_unavailable.svg"
        : isSelected
            ? "assets/icons/ic_seat_selected.svg"
            : "assets/icons/ic_seat_regular.svg";

    return GestureDetector(
      onTap: isUnavailable
          ? null
          : () {
              setState(() {
                if (isSelected) {
                  selectedSeats.remove(seatId);
                } else {
                  selectedSeats.add(seatId);
                }
              });
            },
      child: SizedBox(
        width: 48,
        child: Column(
          children: [
            SvgPicture.asset(assetPath, width: 44, height: 44),
            const SizedBox(height: 4),
            Text(
              seat['name'] ?? '',
              style: xxsRegular.copyWith(
                color: isUnavailable ? textDarkTertiary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalBottomButton() {
    return Container(
      decoration: BoxDecoration(
        color: black00,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 16,
        top: 12,
      ),
      child: CustomButton(
        height: 47,
        onPressed:
            selectedSeats.isEmpty ? null : () => _showConfirmationBottomSheet(),
        child: Text("Pesan", style: mdMedium.copyWith(color: black00)),
      ),
    );
  }

  Widget _buildPriceBottomPanel() {
    final total = getTotalPrice();
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 16,
        top: 12,
      ),
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Detail Harga",
                  style: smRegular.copyWith(color: textDarkTertiary),
                ),
                Row(
                  children: [
                    Text(
                      NumberFormatter.rupiah(total),
                      style: smSemiBold.copyWith(color: jacarta800),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: jacarta800,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isExpanded) ...[
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${selectedSeats.length}x Kursi",
                  style: xsRegular.copyWith(color: textDarkTertiary),
                ),
                Text(
                  NumberFormatter.rupiah(total),
                  style: smSemiBold.copyWith(color: jacarta800),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Harga",
                  style: xsRegular.copyWith(color: textDarkTertiary),
                ),
                Text(
                  NumberFormatter.rupiah(total),
                  style: smSemiBold.copyWith(color: jacarta800),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
          SizedBox(height: 20),
          CustomButton(
            backgroundColor: jacarta800,
            height: 47,
            onPressed: () => _showConfirmationBottomSheet(),
            child: Text("Pesan", style: mdMedium.copyWith(color: black00)),
          ),
        ],
      ),
    );
  }

  void _showConfirmationBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: black00,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).padding.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: textDarkTertiary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),

            // Bus illustration
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/img_bus_interior.png", // Replace with your image
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 24),

            // Confirmation text
            Text(
              "Apakah anda sudah yakin dengan kursi yang anda pilih ?",
              style: lgMedium.copyWith(color: textDarkPrimary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 47,
                    onPressed: () {
                      Navigator.pop(context); // Close confirmation sheet
                      _showBookingHoldBottomSheet(); // Show booking hold sheet
                    },
                    backgroundColor: Colors.transparent,
                    borderColor: primaryColor,
                    child: Text(
                      "Booking",
                      style: mdMedium.copyWith(color: primaryColor),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    height: 47,
                    backgroundColor: jacarta800,
                    onPressed: () {
                      Navigator.pop(context);
                      print('Pesan Sekarang - seats: $selectedSeats');
                    },
                    child: Text(
                      "Pesan Sekarang",
                      style: mdMedium.copyWith(color: black00),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingHoldBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false, // Prevent back button dismiss
        child: Container(
          decoration: BoxDecoration(
            color: black00,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: textDarkTertiary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),

              // Illustration
              Center(
                child: Image.asset(
                  "assets/images/img_no_deposit.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 24),

              // Title
              Text(
                "Booking Kursi Hanya Bertahan Selama 10 menit",
                style: lgSemiBold.copyWith(color: textDarkPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),

              // Description
              Text(
                "Jika Dalam 10 menit Tidak dilakukan Pemesanan Maka Status Kursi Akan Kembali Tersedia di Aplikasi",
                style: smRegular.copyWith(color: textDarkTertiary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),

              // Confirm button
              CustomButton(
                height: 47,
                backgroundColor: jacarta800,
                onPressed: () {
                  Navigator.pop(context); // Close booking hold sheet
                  // Start booking hold timer and navigate to next screen
                  print('Booking hold started for seats: $selectedSeats');
                  // TODO: Navigate to booking details or payment screen
                },
                child: Text(
                  "Booking Sekarang",
                  style: mdMedium.copyWith(color: black00),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
