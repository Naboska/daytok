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
    final messenger = ScaffoldMessenger.of(context);

    try {
      Share.shareUri(Uri.parse(article.fullurl));
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: article.fullurl));
      messenger.showSnackBar(
        const SnackBar(
          margin: EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
          content: Text('Скопировано в буфер обмена'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final thumbnail = article.thumbnail;

    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          image: thumbnail != null
              ? DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover,
                )
              : null),
      child: Container(
        color: Colors.black.withOpacity(0.8),
        padding: const EdgeInsets.only(left: 16, bottom: 16, right: 6),
        child: DefaultTextStyle(
          style: theme.bodyMedium!.copyWith(color: Colors.white),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      article.title,
                      style:
                          theme.headlineMedium!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      article.extract.trim(),
                      style: theme.bodyMedium!.copyWith(color: Colors.white),
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.1416),
                    child: IconButton(
                      onPressed: () => _shareUrl(context),
                      icon: const Icon(
                        Icons.reply,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
