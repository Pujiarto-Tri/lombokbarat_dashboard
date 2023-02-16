import 'package:flutter/material.dart';
import 'package:ppid_flutter/screens/screen.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  static const routeName = '/document';

  @override
  Widget build(BuildContext context) {
    final ResultData resultData =
        ModalRoute.of(context)?.settings.arguments as ResultData;
    return Container(
      color: Colors.white,
      child: SafeArea(
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
              _DocumentDetail(resultData: resultData),
            ],
          ),
        ),
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
    var theme = Theme.of(context);
    var titleFont = theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold);
    var contentFont = theme.textTheme.bodyMedium!
        .copyWith(color: theme.colorScheme.onPrimaryContainer);
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    resultData.title,
                    style: titleFont,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Kode Dokumen : ${resultData.code}',
                    style: contentFont,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Penerbit : ${resultData.dinas}',
                    style: contentFont,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Kategori Dokumen : ${resultData.type}',
                    style: contentFont,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ukuran : $sizeString $unitString',
                    style: contentFont,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue.shade100,
                backgroundColor: Colors.blue.shade900,
              ),
              onPressed: () {},
              child: const Text("Download")),
        ],
      ),
    );
  }
}
