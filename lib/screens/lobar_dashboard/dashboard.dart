import 'package:flutter/material.dart';
import 'dart:math';
import 'dashboard_component.dart';
import 'package:ppid_flutter/widgets/widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: CustomScrollView(
            slivers: [
              NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  setState(() {
                    _opacity = max(
                      0,
                      min(
                        1,
                        (_opacity + notification.scrollDelta!) /
                            (MediaQuery.of(context).size.height * 0.2),
                      ),
                    );
                  });
                  return true;
                },
                child: SliverList(
                  delegate: SliverChildListDelegate([
                    const UserDashboard(),
                    const SizedBox(
                      height: 20,
                    ),
                    // const BannerDashboard(),
                    const StaticBannerDashboard(),
                    const SizedBox(
                      height: 10,
                    ),
                    const MenuDashboard(),
                    const NewsDashboard(),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const AgendaBupatiDashboard(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const BottomNavBar(index: 0),
    );
  }
}
