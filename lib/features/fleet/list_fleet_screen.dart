import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_arrow.dart';
import '../../ui/shared_widget/custom_card_container.dart';
import '../../ui/typography.dart';

class ListFleetScreen extends StatelessWidget {
  const ListFleetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(),
            _buildRoutes(),
            _buildFilters(),
            ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildListFleet(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(color: black00),
      child: const CustomArrow(title: "List Armada"),
    );
  }

  Widget _buildRoutes() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: 6,
      ),
      child: Row(
        children: [
          Icon(Icons.location_pin),
          const SizedBox(width: 4),
          Text("Jakarta - Bandung", style: smMedium),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterItem("30 Desember 2025"),
            const SizedBox(width: 12),
            _buildFilterItem("Pagi 07:00"),
            const SizedBox(width: 12),
            _buildFilterItem("Executive"),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: borderNeutralLight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(text, style: smRegular),
          const SizedBox(width: 6),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: iconDarkTertiary,
          ),
        ],
      ),
    );
  }

  Widget _buildListFleet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CustomCardContainer(
        borderRadius: borderRadius300,
        borderColor: black50,
        borderWidth: 2,
        statusColor: bgSurfaceDanger,
        statusText: "Sisa 5 Kursi",
        statusTextColor: textDanger,
        statusIcon: "assets/images/ic_seat.svg",
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                SvgPicture.asset(
                  "assets/images/ic_bus.svg",
                  height: 40,
                  width: 40,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shantika Executive",
                        style: smMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Jakarta - Bandung",
                        style: xxsRegular.copyWith(
                          color: textDarkTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 80),
              ],
            ),


            Row(
              children: [
                Expanded(
                  child: _buildLocation(
                    "Jakarta",
                    "Terminal Kampung Rambutan",
                    primaryColor,
                  ),
                ),
                // Container(
                //   width: 50,
                //   height: 2,
                //   color: borderNeutralLight,
                //   margin: const EdgeInsets.symmetric(horizontal: 8),
                // ),
                // Expanded(
                //   child: _buildLocation(
                //     "Bandung",
                //     "Terminal Leuwipanjang",
                //     iconDisabled,
                //   ),
                // ),
              ],
            ),

            const SizedBox(height: 20),

            // PRICE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mulai Dari",
                  style: smRegular.copyWith(color: textDarkTertiary),
                ),
                Text(
                  "Rp 175.000",
                  style: mdSemiBold.copyWith(color: primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocation(
      String title,
      String subtitle,
      Color iconColor,
      ) {
    return Row(
      children: [
        Icon(Icons.location_pin, color: iconColor, size: 21),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: xsMedium),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: xxsRegular.copyWith(color: textDarkTertiary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
