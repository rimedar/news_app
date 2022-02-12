import 'package:news_app/src/domain/entities/source.dart';

class SourceModel extends Source {
  const SourceModel({
    final String? id,
    final String? name,
  }) : super(id: id, name: name);
  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
