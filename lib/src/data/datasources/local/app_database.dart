import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:news_app/src/data/datasources/local/DAOs/article_dao.dart';
import 'package:news_app/src/data/datasources/local/converters/source_type_converter.dart';
import 'package:news_app/src/domain/entities/article.dart';

part 'app_database.g.dart';

@TypeConverters([SourceTypeConverter])
@Database(version: 1, entities: [Article])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
