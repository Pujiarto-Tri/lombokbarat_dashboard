import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/opd_link_data.dart';

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: List.generate(opdLink.length, (index) {
          final lobarAppMenu = opdLink[index];
          return SizedBox(
            child: Card(
              elevation: 1,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, lobarAppMenu['routeName'],
                      arguments: lobarAppMenu['arguments']);
                },
                child: Column(
                  children: <Widget>[Text(lobarAppMenu['web_name'])],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
