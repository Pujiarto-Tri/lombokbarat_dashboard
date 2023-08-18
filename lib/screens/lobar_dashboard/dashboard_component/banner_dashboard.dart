import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/banner_dashboard_model.dart';

class BannerDashboard extends StatelessWidget {
  const BannerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: bannerDashboard.length,
            itemBuilder: (context, index) {
              final banner = bannerDashboard[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, banner['routeName'],
                        arguments: banner['arguments']);
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
              );
            },
          ),
        ),
      ],
    );
  }
}
