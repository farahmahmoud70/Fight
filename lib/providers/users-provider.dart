import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserInfoProvider with ChangeNotifier {
  Map<String, dynamic> userInfo = {
    'idNum': '',
    'firstName': '',
    "lastName": "",
    "phoneNum": "",
    "userType": "",
    "additionalInfo": {
      'foodandwater': false,
      'medicalcare': false,
      "capacity": "0",
      "disablecare": false,
      "animalcare": false,
      "type": "",
      "location": null
    },
  };

  void createUser(info) {
    userInfo = info;
    notifyListeners();
  }

  void updateUserAdditionalInfo(additionalInfo) {
    userInfo["additionalInfo"] = additionalInfo;
    notifyListeners();
  }

  void updateUserPersonalInfo(personalInfo) {
    userInfo = personalInfo;
    notifyListeners();
  }
}
