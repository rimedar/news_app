import 'package:floor/floor.dart';
import 'package:news_app/src/domain/entities/source.dart';

class SourceTypeConverter extends TypeConverter<Source, String> {
  @override
  Source decode(String databaseValue) {
    final List<String> result = databaseValue.split(',');
    // databaseValue.split(',') ?? const ['non', 'non'];
    return Source(id: result.first, name: result.last);
  }

  @override
  String encode(Source value) {
    final String result = '${value.id}, ${value.name}';
    return result;
  }
}
