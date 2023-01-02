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
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(index: 0),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: const [SearchDocument(), LatestDocument()],
      ),
    );
  }
}

class LatestDocument extends StatefulWidget {
  const LatestDocument({super.key});
  @override
  LatestDocumentState createState() => LatestDocumentState();
}

class LatestDocumentState extends State<LatestDocument> {
  Ppid ppid = Ppid();
  bool _isLoading = false;

  Future<void> _loadNextPage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Ppid load = await ppid.previousPage();
      setState(() {
        // Add the new results to the existing list
        ppid.results?.addAll(load.results ?? []);
        // Update the previous and next links
        ppid.previous = load.previous;
        ppid.next = load.next;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error loading next page: $e"),
          duration: const Duration(seconds: 3),
        ),
      );
      // Display an error message to the user
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<Ppid>(
          future: ppid.results == null ? fetchPpidModel() : Future.value(ppid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            if (snapshot.hasData) {
              ppid = snapshot.data!;
              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.results!.length,
                itemBuilder: ((context, index) {
                  Results result = snapshot.data!.results![index];
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.outline),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    result.title ?? "Failed to fetch data",
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
                                    result.dinas ?? "Failed to fetch data",
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    result.type ?? "Failed to fetch data",
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
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
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        const SizedBox(
          height: 8,
        ),
        _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _loadNextPage,
                child: const Text("Load more data"),
              ),
      ],
    );
  }
}

class SearchDocument extends StatefulWidget {
  const SearchDocument({super.key});

  @override
  SearchDocumentState createState() => SearchDocumentState();
}

class SearchDocumentState extends State<SearchDocument> {
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
