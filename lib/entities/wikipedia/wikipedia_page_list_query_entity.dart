import 'package:equatable/equatable.dart';

import 'wikipedia_query_entity.dart';

class WikipediaPageListQueryEntity
    extends WikipediaQueryEntity<WikipediaPagesEntity> {
  WikipediaPageListQueryEntity.fromJson(Map<String, dynamic> json)
      : super(query: WikipediaPagesEntity.fromJson(json['query']));
}

class WikipediaPagesEntity extends Equatable {
  final List<WikipediaArticleEntity> pages;

  WikipediaPagesEntity.fromJson(Map<String, dynamic> json)
      : pages = Map.from(json['pages'])
            .values
            .map((e) => WikipediaArticleEntity.fromJson(e))
            .toList();

  @override
  List<Object?> get props => [pages];
}

class WikipediaArticleEntity extends Equatable {
  final int pageid;
  final String title;
  final String? thumbnail;
  final String extract;
  final String fullurl;

  WikipediaArticleEntity.fromJson(Map<String, dynamic> json)
      : pageid = json['pageid'],
        title = json['title'],
        thumbnail = json['thumbnail']?['source'],
        extract = json['extract'],
        fullurl = json['fullurl'];

  @override
  List<Object?> get props => [pageid, title, thumbnail, extract, fullurl];
}
