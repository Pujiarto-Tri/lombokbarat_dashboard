import 'package:flutter/material.dart';
import '../models/ppid_api_model.dart';
// import '../widgets/bottom_nav_bar.dart';
import 'screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/ppid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // bottomNavigationBar: const BottomNavBar(index: 0),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            SearchDocument(),
            Expanded(
              child: SingleChildScrollView(child: LatestDocument()),
            ),
          ],
        ),
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
        const SnackBar(
          content: Text("Error loading next page: Ini adalah data terakhir"),
          duration: Duration(seconds: 3),
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
    var theme = Theme.of(context);
    var titleFont = theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold);
    var contentFont = theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.normal);
    var failedToFetch = "Failed to fetch";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder<Ppid>(
          future: ppid.results == null ? fetchPpidModel() : Future.value(ppid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "Error: ${snapshot.error}",
                style: contentFont,
              );
            }
            if (snapshot.hasData) {
              ppid = snapshot.data!;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.results!.length,
                itemBuilder: ((context, index) {
                  Results result = snapshot.data!.results![index];
                  return Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DocumentScreen.routeName,
                            arguments: ResultData(
                              result.title ?? failedToFetch,
                              result.code ?? failedToFetch,
                              result.dinas ?? failedToFetch,
                              result.type ?? failedToFetch,
                              result.slug ?? failedToFetch,
                              result.size ?? failedToFetch,
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
                                    result.title ?? failedToFetch,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: titleFont,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    result.dinas ?? failedToFetch,
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    style: contentFont,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    result.type ?? failedToFetch,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: contentFont,
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
          height: 10,
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        _isLoading
            ? const LinearProgressIndicator()
            : SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue.shade100,
                    backgroundColor: Colors.blue.shade900,
                  ),
                  onPressed: _loadNextPage,
                  child: const Text("Load more data"),
                ),
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
              ).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Data not found!"),
                    duration: Duration(seconds: 3),
                  ),
                );
              });
            },
            decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              filled: true,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
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
  final String slug;
  late final String size;

  ResultData(
      this.title, this.code, this.dinas, this.type, this.slug, this.size);
}
