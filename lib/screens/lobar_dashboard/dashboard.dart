import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/lobar_app_menu_dashboard.dart';
import 'package:ppid_flutter/models/news_model.dart';
import 'package:ppid_flutter/models/agenda_model.dart';
import 'package:ppid_flutter/models/banner_dashboard_model.dart';
import 'package:ppid_flutter/screens/screen.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'dart:math';

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
                              Colors.blue,
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: const TitleDashboard(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const NewsDashboard(),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Card(elevation: 3, child: MenuDashboard()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const BannerDashboard(),
                    const SizedBox(
                      height: 10,
                    ),
                    const AgendaBupatiDashboard(),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
            ],
          ),
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
      height: MediaQuery.of(context).size.height * 0.14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.14,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 2,
                )
              ],
              image: DecorationImage(
                image: AssetImage('assets/images/header_img.png'),
                fit: BoxFit.cover,
              ),
            ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Berita Terbaru',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
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
                                  fit: BoxFit.cover,
                                  image: NetworkImage(article.urlImage),
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

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Aplikasi Kabupaten Lombok Barat',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: List.generate(appMenu.length, (index) {
              final lobarAppMenu = appMenu[index];
              return SizedBox(
                height: 90,
                width: 90,
                child: Card(
                  elevation: 0,
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
        ],
      ),
    );
  }
}

class AgendaBupatiDashboard extends StatefulWidget {
  const AgendaBupatiDashboard({super.key});

  @override
  State<AgendaBupatiDashboard> createState() => _AgendaBupatiDashboardState();
}

class _AgendaBupatiDashboardState extends State<AgendaBupatiDashboard> {
  bool isLoading = true;
  bool isError = false;

  List<Agendas> agendas = [];

  @override
  void initState() {
    super.initState();
    fetchAgendaBupati();
  }

  Future fetchAgendaBupati() async {
    try {
      final url = Uri.parse('https://lombokbaratkab.go.id/sekilas-lobar/');
      final response = await http.get(url);
      dom.Document html = dom.Document.html(response.body);

      final dateAndName = html
          .querySelectorAll(
              'div.container > div.row > aside.col-sm-12.col-md-4.col-lg-3.col-sm-pull-8.col-md-pull-8.col-lg-pull-9.sidebar > div.row > aside.col-sm-6.col-md-12.col-lg-12.widget.execphp-35.widget_execphp > div.execphpwidget > div.list-group > div.list-group-item')
          .map((element) => element.innerHtml.trim())
          .toList();

      final date = dateAndName.map((value) => value.split('<br>')[0]).toList();
      final name = html
          .querySelectorAll(
              'div.container > div.row > aside.col-sm-12.col-md-4.col-lg-3.col-sm-pull-8.col-md-pull-8.col-lg-pull-9.sidebar > div.row > aside.col-sm-6.col-md-12.col-lg-12.widget.execphp-35.widget_execphp > div.execphpwidget > div.list-group > div.list-group-item > b')
          .map((element) => element.text.trim())
          .toList();

      setState(
        () {
          isLoading = false;
          agendas = List.generate(
            date.length,
            (index) => Agendas(date: date[index], name: name[index]),
          );
        },
      );
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Agenda Bupati',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
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
                      fetchAgendaBupati();
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          if (!isLoading && !isError)
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (final agenda in agendas) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Tanggal : "),
                          Text(agenda.date),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              agenda.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (agenda != agendas.last) const Divider(),
                    ],
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

class BannerDashboard extends StatelessWidget {
  const BannerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
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
