import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/lobar_app_menu_dashboard.dart';
import 'package:web_scraper/web_scraper.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const BottomNavBar(index: 0),
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

  final webScraper = WebScraper('https://lombokbaratkab.go.id/');

  List<Map<String, dynamic>>? newsTitle;
  List<Map<String, dynamic>>? newsContent;
  List<Map<String, dynamic>>? newsPicture;

  void fetchNews() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('/category/berita-terbaru/')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        newsTitle =
            webScraper.getElement('header.article-header > h3 > a', ['href']);
        newsContent = webScraper.getElement('div.article-body', ['class']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
    _controller = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: newsTitle == null
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: 6, // number of cards
                    scrollDirection: Axis.horizontal,
                    physics: const PageScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> attributes =
                          newsTitle![index]['attributes'];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 2,
                          child: InkWell(
                            onTap: () {
                              // handle onTap event here
                            },
                            child: Column(
                              children: <Widget>[Text(attributes['href'])],
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
