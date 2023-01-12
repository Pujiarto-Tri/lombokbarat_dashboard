import 'package:flutter/material.dart';
import 'package:ppid_flutter/screens/home_screen.dart';
import 'package:ppid_flutter/screens/screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const BottomNavBar(index: 0),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 45, left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [TitleDashboard(), MenuDashboard()],
        ),
      ),
    );
  }
}

class TitleDashboard extends StatelessWidget {
  const TitleDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'PPID Kabupaten Lombok Barat',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 7,
          ),
        ],
      ),
    );
  }
}

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3, // 3 columns
        children: List.generate(6, (index) {
          return Card(
            elevation: 1,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              child: Column(
                children: const <Widget>[Text("Test")],
              ),
            ),
          );
        }),
      ),
    );
  }
}
