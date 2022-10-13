import 'package:equatable/equatable.dart';

class Ppid extends Equatable {
  final int id;
  final String title;
  final String code;
  final String dinas;
  final String type;
  final String size;
  final int viewCount;
  final int downloadCount;
  final String slug;

  const Ppid({
    required this.id,
    required this.title,
    required this.code,
    required this.dinas,
    required this.type,
    required this.size,
    required this.viewCount,
    required this.downloadCount,
    required this.slug,
  });

  static List<Ppid> ppids = [
    const Ppid(
      id: 36,
      title: "DIP Dishubkominfo Lobar",
      code: "DISHUB-001",
      dinas: "DISHUB",
      type: "Informasi Berkala",
      size: "16433",
      viewCount: 2,
      downloadCount: 0,
      slug: "dip-dishubkominfo-lobar",
    ),
    const Ppid(
      id: 39,
      title: "SBU LPSE",
      code: "LPSE-001",
      dinas: "DISKOMINFOTIK",
      type: "Informasi Berkala",
      size: "15641",
      viewCount: 3,
      downloadCount: 2,
      slug: "sbu-lpse",
    ),
    const Ppid(
      id: 40,
      title: "Daftar Nama MA di Lombok Barat",
      code: "DIKBUD-001",
      dinas: "DIKBUD",
      type: "Informasi Berkala",
      size: "15641",
      viewCount: 3,
      downloadCount: 2,
      slug: "daftar-nama-ma-di-lombok-barat",
    ),
  ];

  @override
  List<Object?> get props => [
        id,
        title,
        code,
        dinas,
        type,
        size,
        viewCount,
        downloadCount,
        slug,
      ];
}
