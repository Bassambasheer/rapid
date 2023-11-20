class Data {
  String? id;
  String? name;
  String? designation;

  Data({
    this.id,
    this.name,
    this.designation,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': name,
        'designation': designation,
      };
  static Data fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        name: json['user_name'],
        designation: json['designation'],
      );
}
