import 'package:flutter/foundation.dart';

class NavigationBarProvider with ChangeNotifier {
  int navigationIndex;
  NavigationBarProvider(this.navigationIndex);

  void changeNavigationIndex(index) {
    navigationIndex = index;
    notifyListeners();
  }
}
