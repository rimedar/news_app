import 'package:floor/floor.dart';
import 'package:news_app/src/domain/entities/article.dart';

import '../../../../core/utils/constants.dart';

@dao
abstract class ArticleDao {
  @Query('SELECT * FROM $kArticlesTableName')
  Future<List<Article>> getAllArticles();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> inserArticle(Article article);

  @delete
  Future<void> deleteArticle(Article article);
}
