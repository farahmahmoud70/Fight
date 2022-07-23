import 'package:e_shelter/providers/navigation_bar_provider.dart';
import 'package:e_shelter/providers/users-provider.dart';
import 'package:e_shelter/routes/route.dart';
import 'package:e_shelter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    final navigationBarProvider = Provider.of<NavigationBarProvider>(context);

    onEditInfo() {
      Navigator.of(context).pop();
      navigationBarProvider.changeNavigationIndex(2);
    }

    editButton() {
      if (userInfoProvider.userInfo["userType"] == "") {}
    }

    return Container(
        color: primaryColor,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColorLight,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userInfoProvider.userInfo['firstName'] != ""
                        ? userInfoProvider.userInfo['firstName']
                        : "First Name"),
                    Text(userInfoProvider.userInfo['lastName'] != ""
                        ? userInfoProvider.userInfo['lastName']
                        : "Last Name"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(userInfoProvider.userInfo['idNum'] != ""
                            ? userInfoProvider.userInfo['firstName']
                            : "ID Num."),
                        if (userInfoProvider.userInfo["idNum"] != "")
                          IconButton(
                              onPressed: onEditInfo,
                              icon: Icon(
                                FontAwesomeIcons.penToSquare,
                                color: textColor,
                                size: 20,
                              )),
                      ],
                    )
                  ]),
            ),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                userInfoProvider.userInfo["userType"] == "refugeProvider"
                    ? ListTile(
                        title: Text(
                            "Refugees Info (${userInfoProvider.userInfo['additionalInfo']["capacity"]})"),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      )
                    : ListTile(
                        title: const Text("Refuge Provider Info"),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, refugeesListPage);
                        },
                      ),
                ListTile(
                    title: const Text("Refuge Location"),
                    onTap: () {
                      navigationBarProvider.changeNavigationIndex(1);
                    
                      Navigator.of(context).pop();
                    })
              ],
            )
          ],
        ));
  }
}
