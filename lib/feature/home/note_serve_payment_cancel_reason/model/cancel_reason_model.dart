import 'dart:convert';

class CancelReasonsModel {
  late String id;
  late String title;
  late String branch;

  CancelReasonsModel({
    required this.id,
    required this.title,
    required this.branch,
  });

  factory CancelReasonsModel.fromJson(Map<String, dynamic> json) =>
      CancelReasonsModel.fromMap(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['branch'] = branch;
    return data;
  }

  CancelReasonsModel.fromDbJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    title = json['title'].toString();
    branch = json['branch'].toString();
  }

  factory CancelReasonsModel.fromMap(Map<String, dynamic> json) => CancelReasonsModel(
        id: json["_id"],
        title: json["title"],
        branch: json["branch"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "branch": branch,
      };
}

List<CancelReasonsModel> cancelReasonFromJson(String jsonString) {
  final jsonData = jsonDecode(jsonString);
  return List<CancelReasonsModel>.from(jsonData.map((item) => CancelReasonsModel.fromDbJson(item)));
}
