import 'package:daytok/blocs/blocs.dart';
import 'package:daytok/constants/constants.dart';
import 'package:daytok/entities/entities.dart';
import 'package:daytok/repositories/repositories.dart';

part 'wikipedia_articles_state.dart';

class WikipediaArticlesCubit extends CubitBase<WikipediaArticlesState> {
  WikipediaArticlesCubit() : super(const WikipediaArticlesState());

  final _wikipediaRepository = WikipediaRepository();

  @override
  void init() async {
    if (!AppPlatform.isTest) await loadMore();

    super.init();
  }

  Future<void> loadMore() async {
    emit(state.copyWith(status: CubitStateStatus.loading));

    try {
      final randomArticlesEntity =
          await _wikipediaRepository.getRandomArticleList();
      final pageIds = randomArticlesEntity.query.random.map((e) => e.id);

      final pagesEntity = await _wikipediaRepository.getPages(pageIds);
      if (isClosed) return;

      emit(state.copyWith(
        status: CubitStateStatus.success,
        articleList: [...state.articleList, ...pagesEntity.query.pages],
      ));
    } catch (e) {
      emit(state.copyWith(status: CubitStateStatus.error));
    }
  }
}
