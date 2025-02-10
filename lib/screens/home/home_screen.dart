import 'package:daytok/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Controller _controller;
  int _offset = 5;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _controller = Controller()..addListener(_onScroll);
  }

  void _onScroll(ScrollEvent event) async {
    if (event.pageNo != _offset - 3 || _isLoading) return;

    _isLoading = true;
    final wiki = context.read<WikipediaArticlesCubit>();

    await wiki.loadMore();
    _isLoading = false;
    _offset += 5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 470),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: BlocBuilder<WikipediaArticlesCubit, WikipediaArticlesState>(
              builder: (context, state) {
                final articleList = state.articleList;
                final contentSize = articleList.length;
                final isEmpty = articleList.isEmpty;

                return TikTokStyleFullPageScroller(
                  controller: _controller,
                  contentSize: contentSize.clamp(1, double.maxFinite.toInt()),
                  swipePositionThreshold: 0.05,
                  swipeVelocityThreshold: 2000,
                  animationDuration: const Duration(milliseconds: 400),
                  builder: (BuildContext context, int index) {
                    if (isEmpty) return const ArticleSkeleton();

                    return Article(article: articleList[index]);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
