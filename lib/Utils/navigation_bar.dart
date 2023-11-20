//developer debug
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rapidd_technologies/Utils/context_extension.dart';
import 'package:rapidd_technologies/screens/home_screen.dart';
import 'package:rapidd_technologies/screens/profile_screen.dart';

//notificatiopn handler

class CustomNavigationBar extends StatefulWidget {
  // const CustomNavigationBar({Key? key}) : super(key: key);

  const CustomNavigationBar({
    super.key,
  });

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;

  bool? isTapped;

  PageController? _pageController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigationTapped(int page) {
    _pageController!.animateToPage(page,
        duration: const Duration(microseconds: 300), curve: Curves.ease);
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawerScrimColor: Colors.black.withOpacity(0.2),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: _onItemTapped,
          controller: _pageController,
          children: const [
            HomeScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: navBar());
  }

  Widget navBar() {
    return Container(
      height: context.getHeight() * 0.1,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 0.0), // shadow direction: bottom right
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 6,
                      width: 100,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0
                            ? HexColor('#0e4e8f')
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 6,
                      width: 100,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? HexColor('#0e4e8f')
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          BottomNavigationBar(
            elevation: 0,
            selectedLabelStyle: TextStyle(
                color: HexColor('#0e4e8f'),
                fontSize: 14,
                fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
                fontSize: 14,
                color: HexColor('#ababab'),
                fontWeight: FontWeight.w600),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedIconTheme: IconThemeData(color: HexColor('#ababab')),
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Icon(Icons.home)),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: Icon(Icons.person)),
                  label: 'Profile'),
            ],
            selectedItemColor: HexColor('#0e4e8f'),
            unselectedItemColor: Colors.black,
            onTap: navigationTapped,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            enableFeedback: true,
          ),
        ],
      ),
    );
  }

  ///// Educators Navigation Bar
}
