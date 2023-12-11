import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ppid_flutter/models/telpon_data.dart';

class TelponListScreen extends StatelessWidget {
  const TelponListScreen({super.key});

  static const routeName = '/telpon';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TelponTitle(),
              Expanded(
                  child: SingleChildScrollView(
                child: TelponLinkList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class TelponLinkList extends StatelessWidget {
  const TelponLinkList({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var titleFont = theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold);
    var contentFont = theme.textTheme.bodyMedium!
        .copyWith(color: theme.colorScheme.onPrimaryContainer);
    return Column(
      children: List.generate(telLink.length, (index) {
        final link = telLink[index];
        return Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () async {
                String phoneNumbers = link['nomor_tel'];
                Uri phoneNumber = Uri.parse('tel:$phoneNumbers');
                await launchUrl(phoneNumber);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          link['nama_emergency'],
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
                              link['nomor_tel'],
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

class TelponTitle extends StatelessWidget {
  const TelponTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nomor Telpon Penting Kabupaten Lombok Barat',
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
