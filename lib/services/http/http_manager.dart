import 'http_client.dart';

class HttpManager {
  static final HttpClient wikiClient = HttpClient(
    baseUrl: 'https://ru.wikipedia.org/w',
  );

  const HttpManager._();
}
