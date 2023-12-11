import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/news_model.dart';
import 'package:ppid_flutter/screens/screen.dart';
import 'package:ppid_flutter/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

class NewsDashboard extends StatefulWidget {
  const NewsDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsDashboardState createState() => _NewsDashboardState();
}

class _NewsDashboardState extends State<NewsDashboard> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.8);

  List<Articles> articles = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchNews();
    _controller = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  Future fetchNews() async {
    try {
      final url = Uri.parse(
          'https://lombokbaratkab.go.id/category/berita-terbaru/amp/');
      final response = await http.get(url);
      dom.Document html = dom.Document.html(response.body);

      final titles = html
          .querySelectorAll('div.amp-wp-post-content > h2 > a')
          .map((element) => element.innerHtml.trim())
          .toList();

      final urls = html
          .querySelectorAll('div.amp-wp-post-content > h2 > a')
          .map((element) => element.attributes['href'])
          .toList();

      final urlImages = html
          .querySelectorAll('div.home-post_image > a > amp-img')
          .map((element) => element.attributes['src'])
          .toList();

      setState(() {
        isLoading = false;
        articles = List.generate(
          titles.length,
          (index) => Articles(
            title: titles[index],
            url: urls[index]!,
            urlImage: urlImages[index]!,
          ),
        );
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
      // print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Berita Terbaru',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          if (isLoading) const IsLoading(),
          if (isError)
            Center(
              child: Column(
                children: [
                  const Text("Something wrong when trying to load the data!"),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    child: const Text("Try Again"),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        isError = false;
                      });
                      fetchNews();
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          if (!isLoading && !isError)
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _controller,
                itemCount: articles.length, // number of cards
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(),
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, WebViewScreen.routeName,
                              arguments: {'link': article.url});
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(
                                      article.urlImage),
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  article.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
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
        ],
      ),
    );
  }
}
