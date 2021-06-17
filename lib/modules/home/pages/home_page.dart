import 'package:flutter/material.dart';

import 'package:cubipool2/modules/reservation/presentation/pages/search_reservation_page.dart';
import 'package:cubipool2/modules/search/presentation/pages/search_publication_page.dart';
import 'package:cubipool2/modules/profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  static const PAGE_ROUTE = '/home';
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

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
          PublicationPage(),
          ProfilePage(),
        ],
      ),
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
