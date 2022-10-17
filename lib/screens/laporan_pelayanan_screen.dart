import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class LaporanLayananScreen extends StatelessWidget {
  const LaporanLayananScreen({Key? key}) : super(key: key);

  static const routeName = '/laporanPelayanan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNavBar(index: 2),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: const [_LaporanPelayanan()],
      ),
    );
  }
}

class _LaporanPelayanan extends StatelessWidget {
  const _LaporanPelayanan({
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
            'Laporan Pelayanan',
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
