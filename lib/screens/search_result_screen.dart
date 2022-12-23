import 'package:flutter/material.dart';
import 'package:ppid_flutter/screens/document_screen.dart';
import '../models/ppid_api_model.dart';
import 'home_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  final Ppid ppid;

  const SearchResultsScreen({Key? key, required this.ppid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: ppid.results!.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DocumentScreen.routeName,
                    arguments: ResultData(
                        ppid.results![index].title ?? "Failed to fetch data",
                        ppid.results![index].code ?? "Failed to fetch data",
                        ppid.results![index].dinas ?? "Failed to fetch data",
                        ppid.results![index].type ?? "Failed to fetch data",
                        ppid.results![index].size ?? "Failed to fetch data"),
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
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            ppid.results![index].type ?? "Failed to fetch data",
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}