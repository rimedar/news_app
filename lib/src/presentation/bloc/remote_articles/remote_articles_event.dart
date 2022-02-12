part of 'remote_articles_bloc.dart';

class RemoteArticlesEvent extends Equatable {
  const RemoteArticlesEvent();

  @override
  List<Object?> get props => [];
}

class GetArticles extends RemoteArticlesEvent {
  const GetArticles();
}
