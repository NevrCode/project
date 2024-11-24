import 'package:flutter/material.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/order.dart';
import 'package:project/pages/profile.dart';
import 'package:project/pages/vehicles.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_rounded),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.fire_truck),
    activeIcon: Icon(Icons.fire_truck),
    label: 'Vehicle',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.list_alt),
    activeIcon: Icon(Icons.list_alt_outlined),
    label: 'Order',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    activeIcon: Icon(Icons.person),
    label: 'Profile',
  ),
];

class _IndexState extends State<Index> {
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  late PageController pageController;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    pageController = PageController(initialPage: 0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 237, 73),
        leading: const Icon(Icons.factory_sharp),
        title: Text(
          _tabIndex == 0
              ? "HeavyHub"
              : _tabIndex == 1
                  ? "Vehicle"
                  : _tabIndex == 2
                      ? "Orders"
                      : "Profile",
          style: const TextStyle(fontFamily: 'Poppins-Regular'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        iconSize: 27,
        selectedLabelStyle: const TextStyle(fontFamily: 'Poppins-bold'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins-regular'),
        backgroundColor: const Color.fromARGB(255, 235, 211, 0),
        selectedItemColor: const Color.fromARGB(255, 24, 24, 24),
        unselectedItemColor: const Color.fromARGB(255, 243, 243, 243),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: _navBarItems,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          setState(() {
            tabIndex = v;
          });
        },
        children: const [
          HomePage(),
          VehiclePage(),
          OrderPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
