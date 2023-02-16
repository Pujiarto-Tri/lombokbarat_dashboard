import 'package:flutter/material.dart';
import 'package:ppid_flutter/screens/screen.dart';
import 'package:ppid_flutter/models/ppid_api_model.dart';

class SearchResultsScreen extends StatefulWidget {
  final Ppid ppid;
  const SearchResultsScreen({super.key, required this.ppid});
  @override
  SearchResultsScreenState createState() =>
      // ignore: no_logic_in_create_state
      SearchResultsScreenState(ppid: ppid);
}

class SearchResultsScreenState extends State<SearchResultsScreen> {
  SearchResultsScreenState({required this.ppid});
  final Ppid ppid;

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
          content: Text("Error loading next page: ini adalah data terakhir"),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: ppid.results!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              DocumentScreen.routeName,
                              arguments: ResultData(
                                  ppid.results![index].title ??
                                      "Failed to fetch data",
                                  ppid.results![index].code ??
                                      "Failed to fetch data",
                                  ppid.results![index].dinas ??
                                      "Failed to fetch data",
                                  ppid.results![index].type ??
                                      "Failed to fetch data",
                                  ppid.results![index].slug ??
                                      "Failed to fetch data",
                                  ppid.results![index].size ??
                                      "Failed to fetch data"),
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
                                      ppid.results![index].title ??
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
                                      ppid.results![index].dinas ??
                                          "Failed to fetch data",
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
                                      ppid.results![index].type ??
                                          "Failed to fetch data",
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
            ),
          ],
        ),
      ),
    );
  }
}
