import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/domain/entities/article.dart';
import 'package:news_app/src/domain/usecases/get_saved_articles_usecase.dart';
import 'package:news_app/src/domain/usecases/remove_article_usecase.dart';
import 'package:news_app/src/domain/usecases/save_article_usecase.dart';

part 'local_articles_event.dart';
part 'local_articles_state.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final SaveArticlesUseCase _saveArticlesUseCase;
  final RemoveArticlesUseCase _removeArticlesUseCase;

  LocalArticlesBloc(this._getSavedArticlesUseCase,
      this._saveArticlesUseCase, this._removeArticlesUseCase) : super( const LocalArticlesLoading());

  @override
  Stream<LocalArticlesState> mapEventToState(LocalArticlesEvent event) async* {
    if (event is GetAllSavedArticles) {
      yield* _getAllSavedArticles();
    }
    if (event is RemoveArticle) {
      await _removeArticlesUseCase(params: event.article);
      yield* _getAllSavedArticles();
    }
    if (event is SaveArticle) {
      await _saveArticlesUseCase(params: event.article);
     yield* _getAllSavedArticles();
    }
  }
  Stream<LocalArticlesState> _getAllSavedArticles() async* {
    final articles = await _getSavedArticlesUseCase();
    yield LocalArticlesDone(articles);
  }
}
