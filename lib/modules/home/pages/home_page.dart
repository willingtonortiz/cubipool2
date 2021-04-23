import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:flutter/material.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:cubipool2/modules/profile/pages/profile_page.dart';
import 'package:cubipool2/modules/reservation/pages/reservation_page.dart';
import 'package:cubipool2/modules/search/pages/search_page.dart';

class HomePage extends StatefulWidget {
  static const PAGE_ROUTE = '/home';
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   final jwtService = JwtService();
  //   jwtService.removeToken();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            currentIndex = page;
          });
        },
        children: [
          ReservationPage(),
          SearchPage(),
          ProfilePage(),
        ],
      ),
    );
  }

  Widget _buildFancyBottomNavigationBar() {
    return FancyBottomNavigation(
      barBackgroundColor: Theme.of(context).primaryColor,
      circleColor: Colors.white,
      textColor: Colors.white,
      activeIconColor: Theme.of(context).primaryColor,
      inactiveIconColor: Colors.white,
      tabs: [
        TabData(iconData: Icons.bookmark, title: 'Reservar'),
        TabData(iconData: Icons.search, title: 'Buscar'),
        TabData(iconData: Icons.person, title: 'Perfil'),
      ],
      onTabChangedListener: (value) {
        currentIndex = value;
        _pageController.animateToPage(
          value,
          duration: Duration(milliseconds: 200),
          curve: Curves.linear,
        );
        setState(() {});
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[400],
      currentIndex: currentIndex,
      onTap: (value) {
        currentIndex = value;
        _pageController.animateToPage(
          value,
          duration: Duration(milliseconds: 200),
          curve: Curves.linear,
        );

        setState(() {});
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Reservar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
