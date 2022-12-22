import 'package:flutter/material.dart';
import 'package:ppid_flutter/screens/search_result_screen.dart';
import '../models/ppid_api_model.dart';
import '../widgets/bottom_nav_bar.dart';
import 'screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    Future<Ppid> ppidModelFuture = fetchPpidModel();
    List<String> tabs = ['Latest', 'Most View', 'Most Download'];
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        bottomNavigationBar: const BottomNavBar(index: 0),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [SearchDocument(), TabCategory(tabs: tabs)],
        ),
      ),
    );
  }
}

class TabCategory extends StatelessWidget {
  const TabCategory({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    Future<Ppid> ppidModelFuture = fetchPpidModel();
    return Column(
      children: [
        TabBar(
          isScrollable: false,
          indicatorColor: Colors.black,
          tabs: tabs
              .map(
                (tab) => Tab(
                  icon: Text(
                    tab,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<Ppid>(
          future: ppidModelFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: tabs
                      .map((tab) => ListView.builder(
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: ((context, index) {
                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        DocumentScreen.routeName,
                                        arguments: ResultData(
                                          snapshot.data!.results?[index]
                                                  .title ??
                                              "Failed to fetch",
                                          snapshot.data!.results?[index].code ??
                                              "Failed to fetch",
                                          snapshot.data!.results?[index]
                                                  .dinas ??
                                              "Failed to fetch",
                                          snapshot.data!.results?[index].type ??
                                              "Failed to fetch",
                                          snapshot.data!.results?[index].size ??
                                              "Failed to fetch",
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                snapshot.data!.results?[index]
                                                        .title ??
                                                    "Failed to fetch data",
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                snapshot.data!.results?[index]
                                                        .dinas ??
                                                    "Failed to fetch data",
                                                maxLines: 3,
                                                overflow: TextOverflow.clip,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                snapshot.data!.results?[index]
                                                        .type ??
                                                    "Failed to fetch data",
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ))
                      .toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}

class SearchDocument extends StatefulWidget {
  const SearchDocument({super.key});

  @override
  _SearchDocumentState createState() => _SearchDocumentState();
}

class _SearchDocumentState extends State<SearchDocument> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'PPID Kabupaten Lombok Barat',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            'Cari Dokumen',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _controller,
            onFieldSubmitted: (value) {
              fetchSearch(_controller.text).then(
                (ppid) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsScreen(ppid: ppid),
                    ),
                  );
                },
              );
            },
            decoration: InputDecoration(
                hintText: 'Search',
                fillColor: Colors.grey.shade200,
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                )),
          )
        ],
      ),
    );
  }
}

class ResultData {
  final String title;
  final String code;
  final String dinas;
  final String type;
  late final String size;

  ResultData(this.title, this.code, this.dinas, this.type, this.size);
}
