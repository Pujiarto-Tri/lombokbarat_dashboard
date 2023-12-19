import 'package:flutter/material.dart';
import 'dart:math';
import 'dashboard_component.dart';

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
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.18,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_lombokbarat.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Kabupaten Lombok Barat",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  background: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/kantor_bupati.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.0)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.14,
                    //   decoration: const BoxDecoration(
                    //     color: Colors.white,
                    //   ),
                    //   child: const TitleDashboard(),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    // const BannerDashboard(),
                    const StaticBannerDashboard(),
                    const SizedBox(
                      height: 10,
                    ),
                    const NewsDashboard(),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: MenuDashboard(),
                    ),
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
