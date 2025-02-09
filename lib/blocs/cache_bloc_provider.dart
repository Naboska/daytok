import 'package:daytok/blocs/blocs.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CacheBlocProvider extends StatelessWidget {
  const CacheBlocProvider({
    super.key,
    required this.builder,
    this.shouldBuild,
  });

  final WidgetBuilder builder;
  final VoidCallback? shouldBuild;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<WikipediaArticlesCubit>(
          create: (context) => WikipediaArticlesCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          shouldBuild?.call();

          return builder(context);
        },
      ),
    );
  }
}
