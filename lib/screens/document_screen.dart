import 'package:flutter/material.dart';
import 'home_screen.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  static const routeName = '/document';

  @override
  Widget build(BuildContext context) {
    final ResultData resultData =
        ModalRoute.of(context)?.settings.arguments as ResultData;
    return Container(
      color: Colors.white,
      child: Scaffold(
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
          Text(
            resultData.title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
    String sizeString;
    String unitString;
    if (int.parse(resultData.size) < 1000000) {
      // Convert the size in bytes to kilobytes and round the result
      sizeString = ((int.parse(resultData.size) / 1000).round()).toString();
      unitString = "KB";
    } else {
      // Convert the size in bytes to megabytes and round the result
      sizeString = ((int.parse(resultData.size) / 1000000).round()).toString();
      unitString = "MB";
    }
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kode Dokumen : ${resultData.code}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Penerbit : ${resultData.dinas}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Kategori Dokumen : ${resultData.type}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Ukuran : $sizeString $unitString',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
