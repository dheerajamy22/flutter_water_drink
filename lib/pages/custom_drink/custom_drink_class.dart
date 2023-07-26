class custom_drink {
  final String img;
  final String name;
  final String Status;

  custom_drink({
    required this.img,
    required this.name,
    required this.Status,
  });

  factory custom_drink.fromJson(Map<String, dynamic> json) {
    return custom_drink(
        img: json['img'], name: json['name'], Status: json['status']);
  }
  Map<String, dynamic> toJson() {
    return {'img': img, 'name': name, 'status': Status};
  }
}
