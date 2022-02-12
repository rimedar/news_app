import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/bloc/bloc_with_state.dart';
import '../../domain/entities/article.dart';
import '../bloc/remote_articles/remote_articles_bloc.dart';
import '../widgets/article_widget.dart';

class BreakingNewsView extends HookWidget {
  const BreakingNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController
          .addListener(() => _onScrollListener(context, scrollController));
      return scrollController.dispose;
    }, [scrollController]);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(scrollController),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Noticias del día',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3)),
              )),
          Positioned(
            right: 0,
            top: 10,
            child: Builder(
              builder: (context) => GestureDetector(
                onTap: () => _onShowSavedArticlesViewTapped(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Ionicons.bookmark, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
      // actions: [
      // Builder(
      //   builder: (context) => GestureDetector(
      //     onTap: () => _onShowSavedArticlesViewTapped(context),
      //     child: const Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 14),
      //       child: Icon(Ionicons.bookmark, color: Colors.black),
      //     ),
      //   ),
      // ),

      // ],
    );
  }

  Widget _buildBody(ScrollController scrollController) {
    // return _buildArticle(scrollController);
    return BlocBuilder<RemoteArticlesBloC, RemoteArticlesState>(
      builder: (_, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Ionicons.refresh));
        }
        if (state is RemoteArticlesDone) {
          return _buildArticle(
              scrollController, state.articles, state.noMoreData);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildArticle(
    ScrollController scrollController,
    List<Article>? articles,
    bool? noMoreData,
  ) {
    return ListView(
      controller: scrollController,
      children: [
        // Items
        ...List<Widget>.from(
          articles!.map(
            (e) => Builder(
              builder: (context) => ArticleWidget(
                article: e,
                onArticlePressed: (e) => _onArticlePressed(context, e!),
              ),
            ),
          ),
        ),

        // add Loading (circular progress indicator at the end),
        // if there are more items to be loaded
        if (noMoreData!) ...[
          const SizedBox(),
        ] else ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: CupertinoActivityIndicator(),
          ),
        ]
      ],
    );
  }

  void _onScrollListener(
      BuildContext context, ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final remoteArticleBloc = BlocProvider.of<RemoteArticlesBloC>(context);
    final state = remoteArticleBloc.blocProcessState;

    if (currentScroll == maxScroll && state == BlocProcessState.idle) {
      remoteArticleBloc.add(const GetArticles());
    }
  }

  void _onArticlePressed(BuildContext context, Article article) {
    Navigator.pushNamed(context, '/ArticleDetailsView', arguments: article);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticlesView');
  }
}
