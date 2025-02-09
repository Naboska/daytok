import 'package:equatable/equatable.dart';

import 'wikipedia_query_entity.dart';

class WikipediaRandomArticleListQueryEntity
    extends WikipediaQueryEntity<WikipediaRandomQueryEntity> {
  WikipediaRandomArticleListQueryEntity.fromJson(Map<String, dynamic> json)
      : super(query: WikipediaRandomQueryEntity.fromJson(json['query']));
}

class WikipediaRandomQueryEntity extends Equatable {
  final List<WikipediaRandomArticleEntity> random;

  WikipediaRandomQueryEntity.fromJson(Map<String, dynamic> json)
      : random = List.from(json['random'])
            .map((e) => WikipediaRandomArticleEntity.fromJson(e))
            .toList();

  @override
  List<Object?> get props => [random];
}

class WikipediaRandomArticleEntity extends Equatable {
  final int id;
  final int ns;
  final String title;

  WikipediaRandomArticleEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        ns = json['ns'],
        title = json['title'];

  @override
  List<Object?> get props => [id, ns, title];
}
