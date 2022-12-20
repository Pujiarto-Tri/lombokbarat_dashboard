import 'package:flutter/material.dart';
import 'home_screen.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  static const routeName = '/document';

  @override
  Widget build(BuildContext context) {
    final ResultData resultData =
        ModalRoute.of(context)?.settings.arguments as ResultData;
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
          _DocumentName(resultData: resultData),
          _DocumentDetail(resultData: resultData),
        ],
      ),
    );
  }
}

class _DocumentName extends StatelessWidget {
  const _DocumentName({
    Key? key,
    required this.resultData,
  }) : super(key: key);

  final ResultData resultData;

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
            resultData.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.25,
                ),
          ),
        ],
      ),
    );
  }
}

class _DocumentDetail extends StatelessWidget {
  const _DocumentDetail({
    Key? key,
    required this.resultData,
  }) : super(key: key);

  final ResultData resultData;

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
              Text(
                resultData.code,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
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
              Text(
                resultData.dinas,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
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
              Text(
                resultData.type,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
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
              Text(
                resultData.size,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
