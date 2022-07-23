import 'package:e_shelter/providers/users-provider.dart';
import 'package:e_shelter/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    Map<String, dynamic> personalUserInfo = {
      'idNum': userInfoProvider.userInfo["idNum"],
      'firstName': userInfoProvider.userInfo["firstName"],
      "lastName": userInfoProvider.userInfo["lastName"],
      "phoneNum": userInfoProvider.userInfo["phoneNum"],
      "userType": userInfoProvider.userInfo["userType"],
      "additionalInfo": userInfoProvider.userInfo["additionalInfo"]
    };

    onPersonalInfoChange(value, key) {
      setState(() {
        personalUserInfo[key] = value;
      });
    }

    onUpdate() {
      if (userInfoProvider.userInfo["idNum"] == "") {
        userInfoProvider.createUser(personalUserInfo);
      } else {
        userInfoProvider.updateUserPersonalInfo(personalUserInfo);
      }
    }

    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Column(
          children: [
            SizedBox(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID Num.',
                ),
                enabled: userInfoProvider.userInfo["idNum"] == "",
                readOnly: userInfoProvider.userInfo["idNum"] != "",
                initialValue: personalUserInfo["idNum"],
                onChanged: (value) => onPersonalInfoChange(value, "idNum"),
              ),
              width: MediaQuery.of(context).size.width - 18,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                initialValue: personalUserInfo["firstName"],
                onChanged: (value) => onPersonalInfoChange(value, "firstName"),
              ),
              width: MediaQuery.of(context).size.width - 18,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                initialValue: personalUserInfo["lastName"],
                onChanged: (value) => onPersonalInfoChange(value, "lastName"),
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
                initialValue: personalUserInfo["phoneNum"],
                onChanged: (value) => onPersonalInfoChange(value, "phoneNum"),
              ),
              width: MediaQuery.of(context).size.width - 18,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 12)),
          ],
        )),
        Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.04),
          child: Button(
              onPressed: onUpdate,
              child: Text(
                  userInfoProvider.userInfo["idNum"] == ""
                      ? 'Create'
                      : 'Update',
                  style: const TextStyle(fontSize: 18))),
        )
      ],
    ));
  }
}
