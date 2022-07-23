import 'package:e_shelter/providers/navigation_bar_provider.dart';
import 'package:e_shelter/providers/users-provider.dart';
import 'package:e_shelter/routes/route.dart';
import 'package:e_shelter/theme/theme.dart';
import 'package:e_shelter/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class RefugeProvider extends StatefulWidget {
  const RefugeProvider({
    Key? key,
  }) : super(key: key);

  @override
  State<RefugeProvider> createState() => _RefugeProviderState();
}

class _RefugeProviderState extends State<RefugeProvider> {
  Map<String, dynamic> refugeProviderInfo = {
    'idNum': '',
    'firstName': '',
    "lastName": "",
    "phoneNum": "",
    "userType": "refugeProvider",
    "additionalInfo": {
      'foodandwater': false,
      'medicalcare': false,
      "capacity": "",
      "disablecare": false,
      "animalcare": false,
      "type": "",
      "location": ""
    }
  };

  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  onLocateMePressed() async {
    Position location = await _determinePosition();
    setState(() {
      refugeProviderInfo["additionalInfo"]["location"] = location;
    });
  }

  onProviderChange(value, key) {
    setState(() {
      refugeProviderInfo[key] = value;
    });
  }

  onAdditionalInfoChange(value, key) {
    setState(() {
      refugeProviderInfo["additionalInfo"][key] = value;
    });
  }

  onPressed() {
    final userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    userInfoProvider.createUser(refugeProviderInfo);
    final navigationBarProvider =
        Provider.of<NavigationBarProvider>(context, listen: false);
    navigationBarProvider.changeNavigationIndex(1);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Refuge Provider Info."),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25, left: 25, right: 25),
              child: Text(
                "As a refuge provider you need to fill this form to provide info for the affected people.",
                style: TextStyle(fontSize: 21),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                ),
                ExpansionTile(
                  title: const Text('Personal Info.'),
                  backgroundColor: primaryColorLight,
                  collapsedBackgroundColor: primaryColor,
                  collapsedTextColor: textColor,
                  collapsedIconColor: textColor,
                  textColor: textColor,
                  iconColor: textColor,
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'ID Num.',
                            ),
                            initialValue: refugeProviderInfo["idNum"],
                            onChanged: (value) =>
                                onProviderChange(value, "idNum"),
                          ),
                          width: MediaQuery.of(context).size.width - 18,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                        SizedBox(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                            ),
                            initialValue: refugeProviderInfo["firstName"],
                            onChanged: (value) =>
                                onProviderChange(value, "firstName"),
                          ),
                          width: MediaQuery.of(context).size.width - 18,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                        SizedBox(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                            ),
                            initialValue: refugeProviderInfo["lastName"],
                            onChanged: (value) =>
                                onProviderChange(value, "lastName"),
                          ),
                          width: MediaQuery.of(context).size.width - 18,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 12)),
                        SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Phone Num',
                            ),
                            initialValue: refugeProviderInfo["phoneNum"],
                            onChanged: (value) =>
                                onProviderChange(value, "phoneNum"),
                          ),
                          width: MediaQuery.of(context).size.width - 18,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 18)),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                ExpansionTile(
                  title: const Text('Refuge Info'),
                  backgroundColor: primaryColorLight,
                  collapsedBackgroundColor: primaryColor,
                  collapsedTextColor: textColor,
                  collapsedIconColor: textColor,
                  textColor: textColor,
                  iconColor: textColor,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11, right: 11),
                        child: ListView(
                          children: [
                            Button(
                                onPressed: onLocateMePressed,
                                child: const Text("Locate me*")),
                            Text("Location: ${refugeProviderInfo["additionalInfo"]
                                ["location"]}"),
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: refugeProviderInfo["location"] != null
                                        ? 12
                                        : 0)),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      child: const Text(
                                        "Provide food and water*",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      width: MediaQuery.of(context).size.width -
                                          70,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "Note: you must be able to provide food and water for 14 days per person.",
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: secondaryColor),
                                      ),
                                      width: MediaQuery.of(context).size.width -
                                          70,
                                    )
                                  ],
                                ),
                                Checkbox(
                                  activeColor: primaryColorDark,
                                  value: refugeProviderInfo["additionalInfo"]
                                      ["foodandwater"],
                                  onChanged: (value) => onAdditionalInfoChange(
                                      value, "foodandwater"),
                                )
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 12)),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      child: const Text(
                                        "Provide medical care*",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      width: MediaQuery.of(context).size.width -
                                          70,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "Note: you must be able to provide the basic medical/health care.",
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: secondaryColor),
                                      ),
                                      width: MediaQuery.of(context).size.width -
                                          70,
                                    )
                                  ],
                                ),
                                Checkbox(
                                  activeColor: primaryColorDark,
                                  value: refugeProviderInfo["additionalInfo"]
                                      ["medicalcare"],
                                  onChanged: (value) => onAdditionalInfoChange(
                                      value, "medicalcare"),
                                )
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 12)),
                            SizedBox(
                              child: const Text(
                                "Please enter the number of refugees that the refuge can handle.",
                                style: TextStyle(fontSize: 20),
                                softWrap: true,
                              ),
                              width: MediaQuery.of(context).size.width - 18,
                            ),
                            SizedBox(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Num. of refugees',
                                ),
                                initialValue:
                                    refugeProviderInfo["additionalInfo"]
                                        ["capacity"],
                                onChanged: (value) =>
                                    onAdditionalInfoChange(value, "capacity"),
                              ),
                              width: MediaQuery.of(context).size.width - 18,
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 12)),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      child: const Text(
                                        "Provide care for disable refugees*",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      width: MediaQuery.of(context).size.width -
                                          70,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "Note: if you are able to provide support/care for disable refugees.",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: secondaryColor),
                                        softWrap: true,
                                      ),
                                      width: MediaQuery.of(context).size.width -
                                          70,
                                    )
                                  ],
                                ),
                                Checkbox(
                                  activeColor: primaryColorDark,
                                  value: refugeProviderInfo["additionalInfo"]
                                      ["disablecare"],
                                  onChanged: (value) => onAdditionalInfoChange(
                                      value, "disablecare"),
                                )
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 12)),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      child: const Text(
                                        "Provide animal refuge*",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      width: MediaQuery.of(context).size.width -
                                          70,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "Note: if you are able to host refugee's animals.",
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: secondaryColor),
                                      ),
                                      width: MediaQuery.of(context).size.width -
                                          70,
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  activeColor: primaryColorDark,
                                  value: refugeProviderInfo["additionalInfo"]
                                      ["animalcare"],
                                  onChanged: (value) => onAdditionalInfoChange(
                                      value, "animalcare"),
                                )
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 12)),
                            SizedBox(
                              child: const Text(
                                "Please enter the refuge type? ex. farm, house, ..etc.",
                                style: TextStyle(fontSize: 20),
                              ),
                              width: MediaQuery.of(context).size.width - 18,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Refuge Type',
                                ),
                                initialValue:
                                    refugeProviderInfo["additionalInfo"]
                                        ["type"],
                                onChanged: (value) =>
                                    onAdditionalInfoChange(value, "type"),
                              ),
                              width: MediaQuery.of(context).size.width - 18,
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 18)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.04),
              child: Button(
                  onPressed: onPressed,
                  child: const Text("Provide Refuge",
                      style: TextStyle(fontSize: 18))),
            ),
          ],
        ),
      ),
    );
  }
}
