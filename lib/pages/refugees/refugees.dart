import 'package:e_shelter/theme/theme.dart';
import 'package:e_shelter/widgets/button/button.dart';
import 'package:flutter/material.dart';

class Refugees extends StatefulWidget {
  const Refugees({
    Key? key,
  }) : super(key: key);

  @override
  State<Refugees> createState() => _RefugeesState();
}

class _RefugeesState extends State<Refugees> {
  onPressed() {
    print("wee");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Refugees Info."),centerTitle: true,),
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25, left: 25, right: 25),
              child: Text(
                "As a refugee you need to fill this form to find the appropriate refuge for you.",
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
                  title: Text('Personal Info.'),
                  backgroundColor: primaryColorLight,
                  collapsedBackgroundColor: primaryColor,
                  collapsedTextColor: textColor,
                  collapsedIconColor: textColor,
                  textColor: textColor,
                  iconColor: textColor,
                  children: <Widget>[
                    ListTile(title: Text('This is tile number 1')),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                ExpansionTile(
                  title: Text('Facilities'),
                  backgroundColor: primaryColorLight,
                  collapsedBackgroundColor: primaryColor,
                  collapsedTextColor: textColor,
                  collapsedIconColor: textColor,
                  textColor: textColor,
                  iconColor: textColor,
                  children: const <Widget>[
                    ListTile(title: Text('This is tile number 1')),
                  ],
                ),
              ],
            )),
             Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.04),
                      child: Button(
                onPressed: onPressed,
                // onPressed: () => onPressed(Routes.Refugees.toString()),
                child: const Text("Find Refuge", style: TextStyle(fontSize: 18))),
                )
            ,
          ],
        ),
      ),
    );
  }
}
