import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final String? id;
  final String? name;
  const Source({
    this.id,
    this.name,
  });

  Source copyWith({
    String? id,
    String? name,
  }) {
    return Source(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];

  @override
  bool get stringify => true;

  
}
