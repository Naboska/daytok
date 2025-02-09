part of 'wikipedia_articles_cubit.dart';

class WikipediaArticlesState extends CubitBaseState {
  final List<WikipediaArticleEntity> articleList;

  const WikipediaArticlesState({
    super.status = CubitStateStatus.loading,
    this.articleList = const [],
  });

  @override
  WikipediaArticlesState copyWith({
    CubitStateStatus? status,
    List<WikipediaArticleEntity>? articleList,
  }) =>
      WikipediaArticlesState(
        status: status ?? this.status,
        articleList: articleList ?? this.articleList,
      );

  @override
  List<Object?> get props => [status, articleList];
}
