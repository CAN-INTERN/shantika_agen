import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_agen/features/fleet/seat_layout_screen.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_arrow.dart';
import '../../ui/shared_widget/custom_card_container.dart';
import '../../ui/typography.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListFleetScreen extends StatelessWidget {
  const ListFleetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: AppBar(
        backgroundColor: black00,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: black950),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Armada',
              style: xlSemiBold.copyWith(color: black950),
            ),
            Text(
              'TANJUNG PRIOK-JAKARTA UTARA. Executive. 2025-12-31.',
              style: xxsRegular.copyWith(color: textDarkSecondary),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 2,
        itemBuilder: (context, index) {
          return _buildFleetCard(context, index);
        },
      ),
    );
  }

  Widget _buildFleetCard(BuildContext context, int index) {
    return CustomCardContainer(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SeatLayoutScreen(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/icons/bus.svg'),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bus P-${index + 1} . Executive',
                      style: mdSemiBold.copyWith(color: black950),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '--bsd--kalideres--poris--bitung--pasar kemis-',
                      style: xsRegular.copyWith(color: textDarkTertiary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Mulai dari',
                    style: xxsRegular.copyWith(color: textDarkTertiary),
                  ),
                  Text(
                    'Rp${260 + (index * 10)}.000',
                    style: lgSemiBold.copyWith(color: navy400),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildLocationRow(
            icon: Icons.location_on_rounded,
            iconColor: navy400,
            title: 'JEPARA',
            subtitle: 'JEPARA',
          ),
          const SizedBox(height: 16),
          _buildLocationRow(
            icon: Icons.location_on_rounded,
            iconColor: primaryColor,
            title: 'TANJUNG PRIOK',
            subtitle: 'JAKARTA UTARA',
            trailing: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFFFE5E5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/icons/car_seat.svg",
                    color: errorColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${30 - (index * 5)} Kursi',
                    style: xsRegular.copyWith(color: errorColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: mdMedium.copyWith(color: black950),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: smRegular.copyWith(color: textDarkSecondary),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
}