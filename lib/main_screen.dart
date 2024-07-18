// ignore_for_file: deprecated_member_use

import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/components/colors.dart';
import 'package:a_group/favorites/favorites_screen.dart';
import 'package:a_group/plots/views/plots_screen.dart';
import 'package:a_group/profile/views/profile_screen.dart';
import 'package:a_group/status/views/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  final MyUser? user;
  const MainScreen({
    super.key,
    this.user,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    PlotsScreen(),
    StatusScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  static const sellerOptions = [
    PlotsScreen(),
    StatusScreen(),
    ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Center(
          child: widget.user?.userType == 'seller' ? sellerOptions.elementAt(_selectedIndex) : _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF191919),
        items: widget.user?.userType == 'seller' ? sellerItems : customerItems,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF56A2FF),
        unselectedItemColor: const Color(0xFF8694A6),
        unselectedFontSize: 14,
        onTap: _onItemTapped,
      ),
    );
  }

  List<BottomNavigationBarItem> get sellerItems {
    return <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.area_chart_rounded),
        label: 'Участки',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.rate_review_outlined),
        label: 'Фильтр',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset('lib/assets/icons/profile.svg', color: AppColors.iconColor, height: 30),
        activeIcon: SvgPicture.asset('lib/assets/icons/profile.svg', color: const Color(0xFF56A2FF), height: 30),
        label: 'Профиль',
      ),
    ];
  }

  List<BottomNavigationBarItem> get customerItems {
    return <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.area_chart_rounded),
        label: 'Участки',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.rate_review_outlined),
        label: 'Фильтр',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border),
        label: 'Избранное',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset('lib/assets/icons/profile.svg', color: AppColors.iconColor, height: 30),
        activeIcon: SvgPicture.asset('lib/assets/icons/profile.svg', color: const Color(0xFF56A2FF), height: 30),
        label: 'Профиль',
      ),
    ];
  }
}
