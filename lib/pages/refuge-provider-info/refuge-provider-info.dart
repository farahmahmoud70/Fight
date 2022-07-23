import 'package:e_shelter/providers/users-provider.dart';
import 'package:e_shelter/theme/theme.dart';
import 'package:e_shelter/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefugeProviderInfo extends StatefulWidget {
  const RefugeProviderInfo({Key? key}) : super(key: key);

  @override
  State<RefugeProviderInfo> createState() => _RefugeProviderInfoState();
}

class _RefugeProviderInfoState extends State<RefugeProviderInfo> {
  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    Map<String, dynamic> additionalInfo = {
      'foodandwater': userInfoProvider.userInfo["additionalInfo"]
          ["foodandwater"],
      'medicalcare': userInfoProvider.userInfo["additionalInfo"]["medicalcare"],
      "capacity": userInfoProvider.userInfo["additionalInfo"]["capacity"],
      "disablecare": userInfoProvider.userInfo["additionalInfo"]["disablecare"],
      "animalcare": userInfoProvider.userInfo["additionalInfo"]["animalcare"],
      "location": userInfoProvider.userInfo["additionalInfo"]["location"]
    };
    onAdditionalInfoChange(value, key) {
      setState(() {
        additionalInfo[key] = value;
      });
    }

    onUpdate() {
      if (userInfoProvider.userInfo["idNum"] == "") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("You can't create new refuge without providing ID Num."),
        ));
      } else {
        userInfoProvider.updateUserAdditionalInfo(additionalInfo);
      }
    }

    return Container(
      child: Expanded(
        child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: ListView(
              children: [
                SizedBox(
                    child: const Text(
                      "Refuge location",
                      style: TextStyle(fontSize: 20),
                    ),
                    width: MediaQuery.of(context).size.width),
                Text("Location: ${additionalInfo["location"]}"),
                const Padding(padding: EdgeInsets.only(bottom: 12)),
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          child: const Text(
                            "Provide food and water*",
                            style: TextStyle(fontSize: 20),
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                        ),
                        SizedBox(
                          child: Text(
                            "Note: you must be able to provide food and water for 14 days per person.",
                            softWrap: true,
                            style:
                                TextStyle(fontSize: 14, color: secondaryColor),
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                        )
                      ],
                    ),
                    Checkbox(
                        value: additionalInfo["foodandwater"],
                        onChanged: (value) =>
                            onAdditionalInfoChange(value, "foodandwater"))
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
                          width: MediaQuery.of(context).size.width - 70,
                        ),
                        SizedBox(
                          child: Text(
                            "Note: you must be able to provide the basic medical/health care.",
                            softWrap: true,
                            style:
                                TextStyle(fontSize: 14, color: secondaryColor),
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                        )
                      ],
                    ),
                    Checkbox(
                        value: additionalInfo["medicalcare"],
                        onChanged: (value) =>
                            onAdditionalInfoChange(value, "medicalcare"))
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
                      initialValue: additionalInfo["capacity"],
                      onChanged: (value) =>
                          onAdditionalInfoChange(value, "capacity")),
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
                          width: MediaQuery.of(context).size.width - 70,
                        ),
                        SizedBox(
                          child: Text(
                            "Note: if you are able to provide support/care for disable refugees.",
                            style:
                                TextStyle(fontSize: 14, color: secondaryColor),
                            softWrap: true,
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                        )
                      ],
                    ),
                    Checkbox(
                        value: additionalInfo["disablecare"],
                        onChanged: (value) =>
                            onAdditionalInfoChange(value, "disablecare"))
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
                          width: MediaQuery.of(context).size.width - 70,
                        ),
                        SizedBox(
                          child: Text(
                            "Note: if you are able to host refugee's animals.",
                            softWrap: true,
                            style:
                                TextStyle(fontSize: 14, color: secondaryColor),
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                        ),
                      ],
                    ),
                    Checkbox(
                        value: additionalInfo["animalcare"],
                        onChanged: (value) =>
                            onAdditionalInfoChange(value, "animalcare"))
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
                      initialValue: additionalInfo["type"],
                      onChanged: (value) =>
                          onAdditionalInfoChange(value, "type")),
                  width: MediaQuery.of(context).size.width - 18,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 12)),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.04),
                  child: Button(
                      onPressed: onUpdate,
                      child:
                          const Text("Update", style: TextStyle(fontSize: 18))),
                )
              ],
            )),
      ),
    );
  }
}
