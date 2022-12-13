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

class Ppid {
  int? count;
  List<Results>? results;

  Ppid({this.count, this.results});

  Ppid.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = title;
    data['code'] = this.code;
    data['dinas'] = this.dinas;
    data['type'] = this.type;
    data['size'] = this.size;
    data['view_count'] = this.viewCount;
    data['download_count'] = this.downloadCount;
    data['slug'] = this.slug;
    return data;
  }
}
