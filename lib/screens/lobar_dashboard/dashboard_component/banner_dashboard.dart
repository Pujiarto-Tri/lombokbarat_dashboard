import 'package:flutter/material.dart';
import 'package:ppid_flutter/screens/screen.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BannerDashboard extends StatefulWidget {
  const BannerDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BannerDashboardState createState() => _BannerDashboardState();
}

class _BannerDashboardState extends State<BannerDashboard> {
  List<String> bannerImageUrls = [];
  List<String> bannerLinks = [];
  bool isLoading = true;
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.85,
  );

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
      final List<Map<String, dynamic>> rawLinks = webScraper.getElement(
        'div.item a', // CSS selector for the anchor tags
        ['href'],
      );

      setState(() {
        bannerImageUrls = rawImages
            .map<String>(
                (element) => '$baseImageUrl${element['attributes']['src']}')
            .toList();
        bannerLinks = rawLinks
            .map<String>((element) => element['attributes']['href'].trim())
            .toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : PageView.builder(
                  controller: _pageController,
                  itemCount: bannerImageUrls.length,
                  itemBuilder: (context, index) {
                    final imageUrl = bannerImageUrls[index];
                    final link = bannerLinks[index];

                    return Center(
                      child: Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              WebViewScreen.routeName,
                              arguments: {'link': link},
                            );
                          },
                          child: Container(
                            height: 120,
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(imageUrl),
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
        ),
      ],
    );
  }
}
