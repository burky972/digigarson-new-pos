import 'dart:convert';

class NoteModel {
  late String id;
  late String title;
  late String note;
  late String branch;

  NoteModel({
    required this.id,
    required this.title,
    required this.note,
    required this.branch,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel.fromMap(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['branch'] = branch;
    return data;
  }

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        id: json["_id"],
        title: json["title"],
        note: json["note"],
        branch: json["branch"],
      );

  NoteModel.fromDbJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    title = json['title'].toString();
    branch = json['branch'].toString();
    note = json['note'].toString();
  }

  Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "note": note,
        "branch": branch,
      };
}

List<NoteModel> noteFromJson(String jsonString) {
  final jsonData = jsonDecode(jsonString);
  return List<NoteModel>.from(jsonData.map((item) => NoteModel.fromDbJson(item)));
}
