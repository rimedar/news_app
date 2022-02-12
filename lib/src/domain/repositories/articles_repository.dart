import 'package:news_app/src/core/params/article_request.dart';
import 'package:news_app/src/core/resourses/data_state.dart';
import 'package:news_app/src/domain/entities/article.dart';

abstract class ArticlesRepository {
  //Api
  Future<DataState<List<Article>>> getBreakingNewsArticles(
    ArticlesRequestParams params,
  );

  //Local Dabatabase
  Future<List<Article>> getSavedArticles();
  Future<void> saveArticle(Article article);
  Future<void> removeArticle(Article article);
}
