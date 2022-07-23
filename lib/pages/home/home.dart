import 'package:e_shelter/pages/map/map.dart';
import 'package:e_shelter/pages/profile/profile.dart';
import 'package:e_shelter/providers/navigation_bar_provider.dart';
import 'package:e_shelter/providers/users-provider.dart';
import 'package:e_shelter/theme/theme.dart';
import 'package:e_shelter/widgets/drawer/drawer.dart';
import 'package:e_shelter/widgets/home/homeWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _children = [const HomeWidget(), const GoogleMapWidget(), const Profile()];

  @override
  Widget build(BuildContext context) {
    final navigationBarProvider = Provider.of<NavigationBarProvider>(context);
    onTabTapped(int index) {
      navigationBarProvider.changeNavigationIndex(index);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            navigationBarProvider.navigationIndex == 2 ? "Profile" : "Home"),
        centerTitle: true,
      ),
      // body: const HomeWidget(),
      body: _children.elementAt(navigationBarProvider.navigationIndex),
      drawer: const Drawer(child: DrawerWidget()),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: navigationBarProvider.navigationIndex,
        backgroundColor: primaryColor,
        selectedItemColor: textColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
          ),
            BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.earthAmericas),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
