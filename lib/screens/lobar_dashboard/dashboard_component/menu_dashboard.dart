import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/lobar_app_menu_dashboard.dart';

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Apps',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      'View All',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                // Limit the number of items to four
                appMenu.length > 4 ? 4 : appMenu.length,
                (index) {
                  final lobarAppMenu = appMenu[index];
                  return SizedBox(
                    height: 100,
                    width: 90,
                    child: Card(
                      color: const Color.fromARGB(99, 93, 163, 255),
                      elevation: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            lobarAppMenu['routeName'],
                            arguments: lobarAppMenu['arguments'],
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: ClipOval(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  color: Colors.white,
                                  child: Image(
                                    image: AssetImage(lobarAppMenu['icon']),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              lobarAppMenu['app_name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
