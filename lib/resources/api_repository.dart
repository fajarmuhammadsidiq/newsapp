import 'package:news/model/headlines_model.dart';

import 'api-provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Headlines> fetchCovidList() {
    return _provider.headlinesNews();
  }

  Future<Headlines> fetchTravelNews() {
    return _provider.travelNews();
  }

  Future<Headlines> fetchMoreSource(String source) {
    return _provider.moreFromSource(source);
  }

  Future<Headlines> fetchExploreNews() {
    return _provider.exploreNews();
  }
}

class NetworkError extends Error {}
