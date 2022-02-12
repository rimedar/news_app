import 'package:news_app/src/core/usecases/usecase.dart';
import 'package:news_app/src/domain/entities/article.dart';
import 'package:news_app/src/domain/repositories/articles_repository.dart';

class RemoveArticlesUseCase implements UseCase<void, Article> {
  final ArticlesRepository _articlesRepository;

  const RemoveArticlesUseCase(this._articlesRepository);
  
  @override
  Future<void> call({Article? params}) {
    return _articlesRepository.removeArticle(params!);
  }
}
