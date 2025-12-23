import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_agen/features/history/history_screen.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/typography.dart';
import 'cubit/update_fcm_token_cubit.dart';
import '../home/home_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key, this.goToHistoryTransaction = false});

  final bool? goToHistoryTransaction;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _initialIndex = 0;
  late UpdateFcmTokenCubit _updateFcmTokenCubit;
  final GlobalKey<RefreshIndicatorState> _orderRefreshKey = GlobalKey();

  List<Widget> get screens => [
    HomeScreen(),
    ChatScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _updateFcmTokenCubit = context.read<UpdateFcmTokenCubit>();
    if (widget.goToHistoryTransaction ?? false) {
      _initialIndex = 2;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            _orderRefreshKey.currentState?.show();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: screens[_initialIndex],
      ),
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
          color: black00,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius500),
            topRight: Radius.circular(borderRadius500),
          ),
          boxShadow: [
            BoxShadow(
              color: black950.withOpacity(0.08),
              blurRadius: borderRadius200,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius500),
            topRight: Radius.circular(borderRadius500),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: black00,
            elevation: 0,
            currentIndex: _initialIndex,
            enableFeedback: false,
            selectedItemColor: textPrimary,
            unselectedItemColor: Colors.transparent,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: xsSemiBold.copyWith(color: textPrimary),
            unselectedLabelStyle: xsSemiBold.copyWith(color: textDarkSecondary),
            iconSize: iconL,
            onTap: (index) {
              setState(() {
                _initialIndex = index;
              });
            },
            items: [
              _navItem(
                index: 0,
                label: 'Beranda',
                outline: 'assets/icons/home_outline.svg',
                filled: 'assets/icons/home_fill.svg',
              ),
              _navItem(
                index: 1,
                label: 'Chat',
                outline: 'assets/icons/chat_outline.svg',
                filled: 'assets/icons/chat_fill.svg',
              ),
              _navItem(
                index: 2,
                label: 'Riwayat',
                outline: 'assets/icons/ticket_outline.svg',
                filled: 'assets/icons/ticket_fill.svg',
              ),
              _navItem(
                index: 3,
                label: 'Profile',
                outline: 'assets/icons/profile_outline.svg',
                filled: 'assets/icons/profile_fill.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem({
    required int index,
    required String label,
    required String outline,
    required String filled,
  }) {
    final isSelected = _initialIndex == index;
    return BottomNavigationBarItem(
      label: label,
      icon: Padding(
        padding: EdgeInsets.only(bottom: 3),
        child: SvgPicture.asset(
          isSelected ? filled : outline,
          color: isSelected ? iconPrimary : iconDarkSecondary,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}