import 'package:e_shelter/pages/refuge-provider-info/refuge-provider-info.dart';
import 'package:e_shelter/pages/refugees-info/refugees-info.dart';
import 'package:e_shelter/providers/users-provider.dart';
import 'package:e_shelter/theme/theme.dart';
import 'package:e_shelter/widgets/personal-info/personal-info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: textColor,
            unselectedLabelColor: primaryColorLight, // for unselected
            labelColor: textColor, // for selected

            tabs: [
              const Tab(
                child: Text("Personal Info.", style: TextStyle(fontSize: 16)),
              ),
              Tab(
                child: Text(
                    userInfoProvider.userInfo["userType"] == ''
                        ? "Additional Info"
                        : userInfoProvider.userInfo["userType"] ==
                                "refugeProvider"
                            ? "Refuge Provider Info"
                            : "Refugee Info",
                    style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
          const Expanded(
              child: TabBarView(
            children: [
              PersonalInfo(),
              RefugeProviderInfo(),
            ],
          ))
        ],
      ),
    );
  }
}
