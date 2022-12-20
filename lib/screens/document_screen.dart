import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/ppid_api_model.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  static const routeName = '/document';

  @override
  Widget build(BuildContext context) {
    final document = ModalRoute.of(context)!.settings.arguments as Results;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          _DocumentName(results: document),
          _DocumentDetail(results: document),
        ],
      ),
    );
  }
}

class _DocumentName extends StatelessWidget {
  const _DocumentName({
    Key? key,
    required this.results,
  }) : super(key: key);

  final Results results;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            results.title ?? "Failed to fetch data",
            // "test",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.25,
                ),
          )
        ],
      ),
    );
  }
}

class _DocumentDetail extends StatelessWidget {
  const _DocumentDetail({
    Key? key,
    required this.results,
  }) : super(key: key);

  final Results results;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'Kode Dokumen : ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(
                width: 10,
              ),
              // Text(
              //   ppid.code,
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodyMedium!
              //       .copyWith(color: Colors.black),
              // ),
            ],
          ),
          Column(
            children: [
              Text(
                'Penerbit : ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(
                width: 10,
              ),
              // Text(
              //   ppid.dinas,
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodyMedium!
              //       .copyWith(color: Colors.black),
              // ),
            ],
          ),
          Column(
            children: [
              Text(
                'Kategori Dokumen : ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(
                width: 10,
              ),
              // Text(
              //   ppid.type,
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodyMedium!
              //       .copyWith(color: Colors.black),
              // ),
            ],
          ),
          Column(
            children: [
              Text(
                'Ukuran : ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(
                width: 10,
              ),
              // Text(
              //   ppid.size,
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodyMedium!
              //       .copyWith(color: Colors.black),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
