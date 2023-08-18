import 'package:flutter/material.dart';
import 'package:ppid_flutter/screens/screen.dart';
import 'package:web_scraper/web_scraper.dart';

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
  final PageController _pageController = PageController(viewportFraction: 0.75);

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
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return _buildCardContainer(
                        const FlashingLoadingAnimation());
                  },
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
                                image: NetworkImage(imageUrl),
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

  Widget _buildCardContainer(Widget content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        width: 350,
        height: 120,
        child: content,
      ),
    );
  }
}

class FlashingLoadingAnimation extends StatefulWidget {
  const FlashingLoadingAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlashingLoadingAnimationState createState() =>
      _FlashingLoadingAnimationState();
}

class _FlashingLoadingAnimationState extends State<FlashingLoadingAnimation> {
  bool _showCard = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _showCard = !_showCard;
        });
        _startAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = [
      Colors.grey[300]!,
      Colors.grey[100]!,
      Colors.grey[300]!
    ];

    return AnimatedOpacity(
      opacity: _showCard ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: 200,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: gradientColors,
            stops: const [0.1, 0.5, 0.9],
            begin: const Alignment(-1.0, 0.0),
            end: const Alignment(1.0, 0.0),
          ),
        ),
      ),
    );
  }
}
