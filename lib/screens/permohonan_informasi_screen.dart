import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class PermohonanInformasiScreen extends StatelessWidget {
  const PermohonanInformasiScreen({Key? key}) : super(key: key);

  static const routeName = '/permohonanInformasi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNavBar(index: 1),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: const [_PermohonanInformasiTitle()],
      ),
    );
  }
}

class _PermohonanInformasiTitle extends StatelessWidget {
  const _PermohonanInformasiTitle({
    Key? key,
  }) : super(key: key);

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
            'Permohonan Informasi',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.25,
                ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            'Silahkan Lengkapi Data',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Name',
                fillColor: Colors.grey.shade200,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Kategori',
                fillColor: Colors.grey.shade200,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Dinas',
                fillColor: Colors.grey.shade200,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
