import 'package:flutter/material.dart';
import 'package:ppid_flutter/models/agenda_model.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

class AgendaBupatiDashboard extends StatefulWidget {
  const AgendaBupatiDashboard({super.key});

  @override
  State<AgendaBupatiDashboard> createState() => _AgendaBupatiDashboardState();
}

class _AgendaBupatiDashboardState extends State<AgendaBupatiDashboard> {
  bool isLoading = true;
  bool isError = false;

  List<Agendas> agendas = [];

  @override
  void initState() {
    super.initState();
    fetchAgendaBupati();
  }

  Future fetchAgendaBupati() async {
    try {
      final url = Uri.parse('https://lombokbaratkab.go.id/sekilas-lobar/');
      final response = await http.get(url);
      dom.Document html = dom.Document.html(response.body);

      final dateAndName = html
          .querySelectorAll(
              'div.container > div.row > aside.col-sm-12.col-md-4.col-lg-3.col-sm-pull-8.col-md-pull-8.col-lg-pull-9.sidebar > div.row > aside.col-sm-6.col-md-12.col-lg-12.widget.execphp-35.widget_execphp > div.execphpwidget > div.list-group > div.list-group-item')
          .map((element) => element.innerHtml.trim())
          .toList();

      final date = dateAndName.map((value) => value.split('<br>')[0]).toList();
      final name = html
          .querySelectorAll(
              'div.container > div.row > aside.col-sm-12.col-md-4.col-lg-3.col-sm-pull-8.col-md-pull-8.col-lg-pull-9.sidebar > div.row > aside.col-sm-6.col-md-12.col-lg-12.widget.execphp-35.widget_execphp > div.execphpwidget > div.list-group > div.list-group-item > b')
          .map((element) => element.text.trim())
          .toList();

      setState(
        () {
          isLoading = false;
          agendas = List.generate(
            date.length,
            (index) => Agendas(date: date[index], name: name[index]),
          );
        },
      );
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Agenda Bupati',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (isLoading)
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 110,
                  width: 125,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("Loading Data..."),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          if (isError)
            Center(
              child: Column(
                children: [
                  const Text("Something wrong when trying to load the data!"),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    child: const Text("Try Again"),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        isError = false;
                      });
                      fetchAgendaBupati();
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          if (!isLoading && !isError)
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (final agenda in agendas) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Tanggal : "),
                          Text(agenda.date),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              agenda.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (agenda != agendas.last) const Divider(),
                    ],
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
