import 'package:e_shelter/routes/route.dart';
import 'package:e_shelter/widgets/button/button.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onPressed(String route) {
      Navigator.pushNamed(context, route);
    }

    return Container(
      width: double.infinity,
      child: Column(
          children: [
            const Text(
              'Who are you?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
            ),
            Container(
              width: double.infinity,
              child: Column( children: [
                Button(
                    onPressed: () => onPressed(refugeProviderPage),
                    child: const Text("I have a refuge", style: TextStyle(fontSize: 18))),
                   const Padding(padding: EdgeInsets.only(bottom: 20)),
                Button(
                    onPressed: () => onPressed(refugeesPage),
                   
                    child: const Text("I need a refuge", style: TextStyle(fontSize: 18))),
              ]),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center),
    );
  }
}
