import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/data/datasources/local/app_database.dart';
import 'package:news_app/src/data/datasources/remote/news_api_service.dart';
import 'package:news_app/src/data/repositories/articles_repository_impl.dart';
import 'package:news_app/src/domain/repositories/articles_repository.dart';
import 'package:news_app/src/domain/usecases/get_articles_usecase.dart';
import 'package:news_app/src/domain/usecases/get_saved_articles_usecase.dart';
import 'package:news_app/src/domain/usecases/remove_article_usecase.dart';
import 'package:news_app/src/domain/usecases/save_article_usecase.dart';
import 'package:news_app/src/presentation/bloc/local_articles/local_articles/local_articles_bloc.dart';
import 'package:news_app/src/presentation/bloc/remote_articles/remote_articles_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //DB Initializacion
  final database =
      await $FloorAppDatabase.databaseBuilder(kDatabaseName).build();
  injector.registerSingleton<AppDatabase>(database);

  // Client
  injector.registerSingleton<Dio>(Dio());

  // Dependencies
  injector.registerSingleton<NewsApiService>(
    NewsApiService(
      injector(),
    ),
  );

  injector.registerSingleton<ArticlesRepository>(
    ArticlesRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  // UseCases
  injector.registerSingleton<GetArticlesUseCase>(
    GetArticlesUseCase(
      injector(),
    ),
  );

  injector.registerSingleton<GetSavedArticlesUseCase>(
    GetSavedArticlesUseCase(
      injector(),
    ),
  );
  injector.registerSingleton<SaveArticlesUseCase>(
    SaveArticlesUseCase(
      injector(),
    ),
  );
  injector.registerSingleton<RemoveArticlesUseCase>(
    RemoveArticlesUseCase(
      injector(),
    ),
  );

  // Bloc
  injector.registerFactory<RemoteArticlesBloC>(
    () => RemoteArticlesBloC(
      injector(),
    ),
  );

  injector.registerFactory<LocalArticlesBloc>(
    () => LocalArticlesBloc(
      injector(),
      injector(),
      injector(),
    ),
  );
}
