import 'dart:convert';

class ServeModel {
  late String id;
  late String title;
  late String description;
  late String branch;

  ServeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.branch,
  });

  factory ServeModel.fromJson(Map<String, dynamic> json) => ServeModel.fromMap(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['branch'] = branch;
    return data;
  }

  ServeModel.fromDbJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    branch = json['branch'].toString();
    description = json['description'].toString();
  }

  factory ServeModel.fromMap(Map<String, dynamic> json) => ServeModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        branch: json["branch"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "branch": branch,
      };
}

List<ServeModel> serveFromJson(String jsonString) {
  final jsonData = jsonDecode(jsonString);
  return List<ServeModel>.from(jsonData.map((item) => ServeModel.fromDbJson(item)));
}
