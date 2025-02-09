import 'package:equatable/equatable.dart';

class WikipediaQueryEntity<T> extends Equatable {
  final T query;

  const WikipediaQueryEntity({required this.query});

  @override
  List<Object?> get props => [query];
}
