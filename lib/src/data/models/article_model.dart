import 'package:news_app/src/domain/entities/article.dart';

import 'source_model.dart';

class ArticleModel extends Article {
  const ArticleModel({
    final int? id,
    required final SourceModel source,
    final String? author,
    final String? title,
    final String? description,
    final String? url,
    final String? urlToImage,
    final String? publishedAt,
    final String? content,
  }) : super(
          id: id,
          source: source,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic>? map) {
    return ArticleModel(
      source: SourceModel.fromJson(map!['source'] as Map<String, dynamic>),
      id: map['id']?.toInt() ?? 0,
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'] ?? '',
    );
  }
}
