import 'package:e_shelter/pages/home/home.dart';
import 'package:e_shelter/pages/map/map.dart';
import 'package:e_shelter/pages/profile/profile.dart';
import 'package:e_shelter/pages/refuge-provider/refuge-provider.dart';
import 'package:e_shelter/pages/refugees/refugees.dart';
import 'package:e_shelter/pages/refugess_list/refugess_list.dart';
import 'package:flutter/material.dart';

// variable for our route names
const String refugeProviderPage = 'refugeProvider';
const String refugeesPage = 'refugees';
const String homePage = 'home';
const String refugeesListPage = 'refugeesList';

// controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const Home());
    case refugeProviderPage:
      return MaterialPageRoute(builder: (context) => const RefugeProvider());
    case refugeesPage:
      return MaterialPageRoute(builder: (context) => const Refugees());
      case refugeesListPage:
      return MaterialPageRoute(builder: (context) => const RefugeesList());

    default:
      throw ('this route name does not exist');
  }
}
