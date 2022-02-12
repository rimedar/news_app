import 'package:news_app/src/core/usecases/usecase.dart';
import 'package:news_app/src/domain/entities/article.dart';
import 'package:news_app/src/domain/repositories/articles_repository.dart';

class SaveArticlesUseCase implements UseCase<void, Article> {
  final ArticlesRepository _articlesRepository;

  const SaveArticlesUseCase(this._articlesRepository);
  
  @override
  Future<void> call({Article? params}) {
    return _articlesRepository.saveArticle(params!);
  }
}
