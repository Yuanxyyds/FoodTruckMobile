/// The [SectionModel]
class SectionModel {
  String? id;
  String name;

  SectionModel({
    required this.id,
    required this.name,
  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      "id": id,
      "label": name,
    };
    return jsonMap;
  }

  factory SectionModel.fromSnapshot(var document) {
    final data = document.data();
    return SectionModel(
      id: document.id,
      name: data!["label"],
    );
  }
}
