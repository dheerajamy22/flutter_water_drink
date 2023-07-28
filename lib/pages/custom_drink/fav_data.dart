class FavData {
  final String img;
  final String name;
  final String Status;

  FavData({required this.img, required this.name, required this.Status});

  factory FavData.fromJson(Map<String, dynamic> json) {
    return FavData(
        img: json['img'], name: json['name'], Status: json['Status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'name': name,
      'Status': Status,
    };
  }
}
