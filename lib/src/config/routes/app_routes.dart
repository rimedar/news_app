// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:news_app/src/domain/entities/article.dart';
import 'package:news_app/src/presentation/views/article_details_view.dart';
import 'package:news_app/src/presentation/views/breaking_news_view.dart';
import 'package:news_app/src/presentation/views/saved_articles_view.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const BreakingNewsView());
        break;

      case '/ArticleDetailsView':
        return _materialRoute(
            ArticleDetailsView(article: settings.arguments as Article));
        break;

      case '/SavedArticlesView':
        return _materialRoute(const SavedArticlesView());
        break;
      default:
        return _materialRoute(const BreakingNewsView());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
