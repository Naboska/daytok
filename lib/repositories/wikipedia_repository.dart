import 'package:daytok/entities/entities.dart';
import 'package:daytok/services/services.dart';
import 'package:dio/dio.dart';

class WikipediaRepository {
  static const _baseParams = {
    'action': 'query',
    'format': 'json',
    'origin': '*',
  };

  Dio get _wikiClient => HttpManager.wikiClient.instance;

  Future<WikipediaRandomArticleListQueryEntity> getRandomArticleList({
    int limit = 5,
  }) async {
    final queryParams = {
      ..._baseParams,
      'list': 'random',
      'rnlimit': limit,
      'rnnamespace': 0,
    };

    final response = await _wikiClient.get(
      '/api.php',
      queryParameters: queryParams,
    );

    return WikipediaRandomArticleListQueryEntity.fromJson(response.data);
  }

  Future<WikipediaPageListQueryEntity> getPages(Iterable<int> pageids) async {
    final queryParams = {
      ..._baseParams,
      'prop': 'pageimages|extracts|info',
      'pageids': pageids.join('|'),
      'inprop': 'url',
      'exintro': true,
      'pithumbsize': 500,
      'explaintext': true,
    };

    final response = await _wikiClient.get(
      '/api.php',
      queryParameters: queryParams,
    );

    return WikipediaPageListQueryEntity.fromJson(response.data);
  }
}
