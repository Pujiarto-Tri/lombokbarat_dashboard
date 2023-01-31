import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/lobar_app_menu_dashboard.dart';
import 'package:ppid_flutter/models/news_model.dart';
import 'package:ppid_flutter/screens/screen.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [TitleDashboard(), NewsDashboard(), MenuDashboard()],
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
            'Kabupaten Lombok Barat',
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

  @override
  void initState() {
    super.initState();
    fetchNews();
    _controller = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  Future fetchNews() async {
    final url =
        Uri.parse('https://lombokbaratkab.go.id/category/berita-terbaru/amp/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('div.amp-wp-post-content > h2 > a')
        .map((e) => e.innerHtml.trim())
        .toList();

    final urls = html
        .querySelectorAll('div.amp-wp-post-content > h2 > a')
        .map((e) => e.attributes['href'])
        .toList();

    final urlImages = html
        .querySelectorAll('div.home-post_image > a > amp-img')
        .map((e) => e.attributes['src'])
        .toList();

    setState(() {
      articles = List.generate(
        titles.length,
        (index) => Articles(
          title: titles[index],
          url: urls[index]!,
          urlImage: urlImages[index]!,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
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
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, WebViewScreen.routeName,
                            arguments: {'link': article.url});
                      },
                      child: Column(
                        children: <Widget>[
                          Image.network(
                            article.urlImage,
                            width: 50,
                            fit: BoxFit.fitHeight,
                          ),
                          Text(article.title),
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

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 4, // 3 columns
        children: List.generate(appMenu.length, (index) {
          final lobarAppMenu = appMenu[index];
          return SizedBox(
            height: 20,
            width: 20,
            child: Card(
              elevation: 1,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, lobarAppMenu['routeName'],
                      arguments: lobarAppMenu['arguments']);
                },
                child: Column(
                  children: <Widget>[Text(lobarAppMenu['app_name'])],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
