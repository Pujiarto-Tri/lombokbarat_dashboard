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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/kantor_bupati.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.white, Colors.white.withOpacity(0.0)],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  TitleDashboard(),
                  NewsDashboard(),
                  MenuDashboard()
                ],
              ))
        ],
      ),
    );
  }
}

class TitleDashboard extends StatelessWidget {
  const TitleDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              Text(
                'Kabupaten Lombok Barat',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.blue.shade900, fontWeight: FontWeight.w900),
              ),
            ],
          )
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

      // print('Count : ${titles.length}');

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
          Text(
            'Berita Terbaru',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 8,
          ),
          if (isLoading)
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 110,
                  width: 125,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("Loading Data..."),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
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
                      elevation: 2,
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
                                      fit: BoxFit.cover,
                                      image: NetworkImage(article.urlImage))),
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

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 4, // 3 columns
          children: List.generate(appMenu.length, (index) {
            final lobarAppMenu = appMenu[index];
            return SizedBox(
              height: 60,
              width: 60,
              child: Card(
                elevation: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, lobarAppMenu['routeName'],
                        arguments: lobarAppMenu['arguments']);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image(image: AssetImage(lobarAppMenu['icon'])),
                      ),
                      Text(
                        lobarAppMenu['app_name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
