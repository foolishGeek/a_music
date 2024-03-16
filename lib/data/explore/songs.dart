class SongList {
  final int status;
  final List<SongDetail>? songList;
  final String message;

  SongList({
    required this.status,
    this.songList,
    required this.message,
  });

  factory SongList.fromJson(Map<String, dynamic> json) => SongList(
    status: json["status"],
    songList: List<SongDetail>.from(json["response"].map((x) => SongDetail.fromJson(x))),
    message: json["message"],
  );
}

class SongDetail {
  final String id;
  final String title;
  final String img;

  SongDetail({
    required this.id,
    required this.title,
    required this.img,
  });

  factory SongDetail.fromJson(Map<String, dynamic> json) => SongDetail(
    id: json["id"],
    title: json["title"],
    img: json["img"],
  );
}
