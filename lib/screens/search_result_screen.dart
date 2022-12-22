import 'package:flutter/material.dart';
import '../models/ppid_api_model.dart';

class SearchResultsScreen extends StatelessWidget {
  final Ppid ppid;

  const SearchResultsScreen({Key? key, required this.ppid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: ppid.results!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ppid.results![index].title ?? "Failed to fetch data"),
            // Add other fields to display as needed
          );
        },
      ),
    );
  }
}
