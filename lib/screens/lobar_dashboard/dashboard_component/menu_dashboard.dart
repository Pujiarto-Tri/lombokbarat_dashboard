import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/lobar_app_menu_dashboard.dart';

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Aplikasi Kabupaten Lombok Barat',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: List.generate(appMenu.length, (index) {
              final lobarAppMenu = appMenu[index];
              return SizedBox(
                height: 90,
                width: 90,
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, lobarAppMenu['routeName'],
                          arguments: lobarAppMenu['arguments']);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image(image: AssetImage(lobarAppMenu['icon'])),
                        ),
                        Text(
                          lobarAppMenu['app_name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
