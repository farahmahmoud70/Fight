import 'package:flutter/material.dart';

class RefugeesList extends StatelessWidget {
  const RefugeesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Refugees List"),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                "There is no Refugees yet.",
                style: TextStyle(fontSize: 26),
              )
            ],
          ),
        ));
  }
}
