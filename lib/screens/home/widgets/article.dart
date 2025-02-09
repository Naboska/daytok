import 'package:daytok/constants/constants.dart';
import 'package:daytok/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Article extends StatelessWidget {
  const Article({
    super.key,
    required this.article,
  });

  final WikipediaArticleEntity article;

  void _shareUrl(BuildContext context) async {
    if (AppPlatform.isWeb) {
      final messenger = ScaffoldMessenger.of(context);

      await Clipboard.setData(ClipboardData(text: article.fullurl));

      messenger.showSnackBar(
        const SnackBar(
          margin: EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
          content: Text('Скопировано в буфер обмена'),
        ),
      );
    } else {
      Share.shareUri(Uri.parse(article.fullurl));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final thumbnail = article.thumbnail;

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: thumbnail != null
                    ? DecorationImage(
                        image: NetworkImage(thumbnail),
                        fit: BoxFit.cover,
                      )
                    : null),
            child: Container(
              color: Colors.black.withOpacity(0.6),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 76),
              child: DefaultTextStyle(
                style: theme.bodyMedium!.copyWith(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      article.title,
                      style:
                          theme.headlineMedium!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      article.extract,
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            onPressed: () => _shareUrl(context),
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
