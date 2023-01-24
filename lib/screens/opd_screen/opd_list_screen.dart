import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/opd_link_data.dart';

class OpdListScreen extends StatelessWidget {
  const OpdListScreen({Key? key}) : super(key: key);

  static const routeName = '/opd';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            OpdTitle(),
            Expanded(
                child: SingleChildScrollView(
              child: OpdLinkList(),
            ))
          ],
        ),
      ),
    );
  }
}

class OpdLinkList extends StatelessWidget {
  const OpdLinkList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: List.generate(opdLink.length, (index) {
          final link = opdLink[index];
          return SizedBox(
            child: Card(
              elevation: 1,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, link['routeName'],
                      arguments: link['arguments']);
                },
                child: Column(
                  children: <Widget>[Text(link['web_name'])],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class OpdTitle extends StatelessWidget {
  const OpdTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'OPD Kabupaten Lombok Barat',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 7,
          )
        ],
      ),
    );
  }
}
