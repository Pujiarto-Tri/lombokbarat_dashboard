import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/kecamatan_link_data.dart';

class KecamatanListScreen extends StatelessWidget {
  const KecamatanListScreen({super.key});

  static const routeName = '/kecamatan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              KecamatanTitle(),
              Expanded(
                  child: SingleChildScrollView(
                child: KecamatanLinkList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class KecamatanLinkList extends StatelessWidget {
  const KecamatanLinkList({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var titleFont = theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold);
    var contentFont = theme.textTheme.bodyMedium!
        .copyWith(color: theme.colorScheme.onPrimaryContainer);
    return Column(
      children: List.generate(kecLink.length, (index) {
        final link = kecLink[index];
        return Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, link['routeName'],
                    arguments: link['arguments']);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          link['web_name'],
                          style: titleFont,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const Text('Kode Pos : '),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              link['kode_pos'],
                              style: contentFont,
                            ),
                          ],
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
  }
}

class KecamatanTitle extends StatelessWidget {
  const KecamatanTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Kecamatan Kabupaten Lombok Barat',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
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
