import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Ppid> fetchPpidModel() async {
  final response = await http
      .get(Uri.parse('http://ppidbaru.lombokbaratkab.go.id/api/data/'));

  if (response.statusCode == 200) {
    return Ppid.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Ppid> fetchSearch([String? search]) async {
  final response = await http.get(Uri.parse(
      'http://ppidbaru.lombokbaratkab.go.id/api/data/?search=$search'));

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
    return data;
  }
}
