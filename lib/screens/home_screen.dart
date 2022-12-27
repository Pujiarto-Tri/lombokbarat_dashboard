import 'package:flutter/material.dart';
import 'package:ppid_flutter/screens/search_result_screen.dart';
import '../models/ppid_api_model.dart';
import '../widgets/bottom_nav_bar.dart';
import 'screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   static const routeName = '/';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: const BottomNavBar(index: 0),
//       body: ListView(
//         padding: const EdgeInsets.all(20.0),
//         children: [const SearchDocument(), DocumentList()],
//       ),
//     );
//   }
// }

// class DocumentList extends StatefulWidget {
//   @override
//   _DocumentListState createState() => _DocumentListState();
// }

// class _DocumentListState extends State<DocumentList> {
//   Ppid _ppid = Ppid();
//   List<Results> _results = [];
//   int _page = 1;

//   @override
//   void initState() {
//     super.initState();
//     _fetchPpid();
//   }

//   void _fetchPpid() async {
//     print("_fetchPpid() called");
//     final ppid = await fetchPpidModel();
//     setState(() {
//       _ppid = ppid;
//       _results = ppid.results!;
//     });
//   }

//   void _loadMore() async {
//     print("_loadMore() called");
//     print("_ppid: $_ppid");
//     print("_results: $_results");
//     if (_ppid.next != null) {
//       final nextPpid = await _ppid.nextPage();
//       setState(() {
//         _ppid = nextPpid;
//         _results.addAll(nextPpid.results!);
//         _page++;
//       });
//     }
//   }

//   void _loadPrevious() async {
//     print("_loadPrevious() called");
//     print("_ppid: $_ppid");
//     print("_results: $_results");
//     if (_ppid.previous != null) {
//       final previousPpid = await _ppid.previousPage();
//       setState(() {
//         _ppid = previousPpid;
//         _results = previousPpid.results!;
//         _page--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(
//           height: 20,
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: NotificationListener<ScrollEndNotification>(
//             onNotification: (scrollEnd) {
//               if (scrollEnd.metrics.pixels ==
//                   scrollEnd.metrics.minScrollExtent) {
//                 _loadPrevious();
//               } else if (scrollEnd.metrics.pixels ==
//                   scrollEnd.metrics.maxScrollExtent) {
//                 _loadMore();
//               }

//               return true;
//             },
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: _results.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(
//                         color: Theme.of(context).colorScheme.outline),
//                     borderRadius: const BorderRadius.all(Radius.circular(12)),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.pushNamed(
//                           context,
//                           DocumentScreen.routeName,
//                           arguments: ResultData(
//                             _ppid.results?[index].title ?? "Failed to fetch",
//                             _ppid.results?[index].code ?? "Failed to fetch",
//                             _ppid.results?[index].dinas ?? "Failed to fetch",
//                             _ppid.results?[index].type ?? "Failed to fetch",
//                             _ppid.results?[index].size ?? "Failed to fetch",
//                           ),
//                         );
//                       },
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   _ppid.results?[index].title ??
//                                       "Failed to fetch data",
//                                   maxLines: 1,
//                                   overflow: TextOverflow.clip,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyLarge!
//                                       .copyWith(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                 ),
//                                 const SizedBox(
//                                   height: 3,
//                                 ),
//                                 Text(
//                                   _ppid.results?[index].dinas ??
//                                       "Failed to fetch data",
//                                   maxLines: 3,
//                                   overflow: TextOverflow.clip,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall!
//                                       .copyWith(
//                                         fontWeight: FontWeight.normal,
//                                       ),
//                                 ),
//                                 const SizedBox(
//                                   height: 3,
//                                 ),
//                                 Text(
//                                   _ppid.results?[index].type ??
//                                       "Failed to fetch data",
//                                   maxLines: 1,
//                                   overflow: TextOverflow.clip,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall!
//                                       .copyWith(
//                                         fontWeight: FontWeight.normal,
//                                       ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

//-------------------------
// Tab Category still in Developement
//-------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Latest', 'Most View', 'Most Download'];
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar(index: 0),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [const SearchDocument(), TabCategory(tabs: tabs)],
        ),
      ),
    );
  }
}

class TabCategory extends StatefulWidget {
  const TabCategory({required this.tabs});
  final List<String> tabs;
  @override
  _TabCategoryState createState() => _TabCategoryState(tabs: tabs);
}

class _TabCategoryState extends State<TabCategory> {
  _TabCategoryState({required this.tabs});
  final List<String> tabs;

  Ppid ppid = Ppid();
  bool _isLoading = false;

  Future<void> _loadNextPage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Ppid nextPpid = await ppid.nextPage();
      setState(() {
        ppid = nextPpid;
      });
    } catch (e) {
      print(e);
      // Display an error message to the user
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
          future: ppid.results == null ? fetchPpidModel() : Future.value(ppid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: tabs
                      .map(
                        (tab) => ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.results!.length,
                          itemBuilder: ((context, index) {
                            Results result = snapshot.data!.results![index];
                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      DocumentScreen.routeName,
                                      arguments: ResultData(
                                        result.title ?? "Failed to fetch",
                                        result.code ?? "Failed to fetch",
                                        result.dinas ?? "Failed to fetch",
                                        result.type ?? "Failed to fetch",
                                        result.size ?? "Failed to fetch",
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
                                              result.title ??
                                                  "Failed to fetch data",
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              result.dinas ??
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
                                              result.type ??
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
                        ),
                      )
                      .toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _loadNextPage,
                child: const Text("next"),
              ),
      ],
    );
  }
}
//-----------------------------
// End Of Tab Category
//-----------------------------

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
