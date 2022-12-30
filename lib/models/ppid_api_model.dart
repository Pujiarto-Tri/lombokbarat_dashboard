import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Ppid> fetchPpidModel() async {
  // Make a separate API call to get the count field from the response
  final countResponse = await http
      .get(Uri.parse('http://ppidbaru.lombokbaratkab.go.id/api/data/'));
  final countJson = jsonDecode(countResponse.body);
  final count = countJson['count'];

  // Calculate the last page number
  const recordsPerPage =
      10; // Set this as a constant or read it from the API documentation
  final lastPage =
      count ~/ recordsPerPage + (count % recordsPerPage == 0 ? 0 : 1);

  // Make a request to the API with the page parameter set to the last page
  final response = await http.get(Uri.parse(
      'http://ppidbaru.lombokbaratkab.go.id/api/data/?page=$lastPage'));

  if (response.statusCode == 200) {
    return Ppid.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Ppid> fetchSearch(String search) async {
  // Make a separate API call to get the count field from the response
  final countResponse = await http.get(Uri.parse(
      'http://ppidbaru.lombokbaratkab.go.id/api/data/?search=$search'));
  final countJson = jsonDecode(countResponse.body);
  final count = countJson['count'];

  // Calculate the last page number
  const recordsPerPage =
      10; // Set this as a constant or read it from the API documentation
  final lastPage =
      count ~/ recordsPerPage + (count % recordsPerPage == 0 ? 0 : 1);

  // Make a request to the API with the page parameter set to the last page and the search parameter set to the search term
  final response = await http.get(Uri.parse(
      'http://ppidbaru.lombokbaratkab.go.id/api/data/?page=$lastPage&search=$search'));

  if (response.statusCode == 200) {
    return Ppid.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class Ppid {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  Ppid({this.count, this.next, this.previous, this.results});

  Ppid.fromJson(Map<String, dynamic> json) {
    // print("Ppid.fromJson(): $json");
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
      results!.sort((a, b) => b.date!.compareTo(a
          .date!)); // Sort the list of results by the date field in descending order
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Future<Ppid> nextPage() async {
    if (next == null) {
      return Future.value(Ppid());
    }
    final response = await http.get(Uri.parse(next!));

    if (response.statusCode == 200) {
      return Ppid.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Ppid> previousPage() async {
    final response = await http.get(Uri.parse(previous!));

    if (response.statusCode == 200) {
      return Ppid.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Results {
  int? id;
  String? title;
  String? code;
  String? dinas;
  String? type;
  String? size;
  int? viewCount;
  int? downloadCount;
  String? slug;
  DateTime? date;

  Results(
      {this.id,
      this.title,
      this.code,
      this.dinas,
      this.type,
      this.size,
      this.viewCount,
      this.downloadCount,
      this.slug});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    dinas = json['dinas'];
    type = json['type'];
    size = json['size'];
    viewCount = json['view_count'];
    downloadCount = json['download_count'];
    slug = json['slug'];
    date = DateTime.fromMillisecondsSinceEpoch(id! * 1000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    data['dinas'] = dinas;
    data['type'] = type;
    data['size'] = size;
    data['view_count'] = viewCount;
    data['download_count'] = downloadCount;
    data['slug'] = slug;
    data['date'] = date;
    return data;
  }
}
