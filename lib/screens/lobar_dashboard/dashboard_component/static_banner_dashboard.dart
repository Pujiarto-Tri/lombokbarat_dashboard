import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/static_banner_model.dart';

class StaticBannerDashboard extends StatefulWidget {
  const StaticBannerDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StaticBannerDashboardState createState() => _StaticBannerDashboardState();
}

class _StaticBannerDashboardState extends State<StaticBannerDashboard> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: staticBanner.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  final banner = staticBanner[index];
                  return Center(
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            banner['routeName'],
                            arguments: banner['arguments'],
                          );
                        },
                        child: Container(
                          height: 120,
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(banner['img']),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: const Text(''),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Positioned(
          bottom: 10.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(staticBanner.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
