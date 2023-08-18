import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

class BannerDashboard extends StatefulWidget {
  const BannerDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BannerDashboardState createState() => _BannerDashboardState();
}

class _BannerDashboardState extends State<BannerDashboard> {
  List<String> bannerImageUrls = [];

  @override
  void initState() {
    super.initState();
    scrapeImages();
  }

  Future<void> scrapeImages() async {
    final webScraper = WebScraper(
        'https://diskominfo.lombokbaratkab.go.id/'); // Replace with the actual website URL
    if (await webScraper.loadWebPage('/')) {
      const baseImageUrl =
          'https://diskominfo.lombokbaratkab.go.id'; // Replace with the actual base URL
      final List<Map<String, dynamic>> rawImages = webScraper.getElement(
        'div.item img', // CSS selector for the images
        ['src'],
      );

      setState(() {
        bannerImageUrls = rawImages
            .map<String>(
                (element) => '$baseImageUrl${element['attributes']['src']}')
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: bannerImageUrls.length,
            itemBuilder: (context, index) {
              final imageUrl = bannerImageUrls[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: InkWell(
                  onTap: () {
                    // Handle the tap action
                  },
                  child: Container(
                    height: 120,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
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
