import 'package:flutter/cupertino.dart';
import 'package:flutter_news_nytapi/models/top_stories_model.dart';
import 'package:flutter_news_nytapi/services/api_service.dart';

class TopStories extends ChangeNotifier {
  List<TopStoriesModel> _topStoriesNewsList = [];

  List<TopStoriesModel> get topStoriesNewsList => _topStoriesNewsList;

  String status = isStatus.stopped.toString();

  refreshTopStoriesList() async {
    status = isStatus.running.toString();
    try {
      _topStoriesNewsList = await APIService().fetchTopStories();
      if (_topStoriesNewsList != null) {
        status = isStatus.successful.toString();
        notifyListeners();
      } else {
        status = isStatus.wasnull.toString();
        print("top stories received was null...");
        print("trying again for ");
        refreshTopStoriesList();
      }
    } catch (e) {
      status = isStatus.error.toString();
      print("\nerror in try catch\n");
      print(e);
    }
    status = isStatus.stopped.toString();
  }
}

enum isStatus {
  wasnull,
  running,
  stopped,
  paused,
  error,
  successful,
}
