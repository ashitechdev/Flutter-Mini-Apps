import 'dart:convert';

import 'package:flutter_news_nytapi/models/top_stories_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<List<TopStoriesModel>> fetchTopStories() async {
    var response = await http.get(
        'https://api.nytimes.com/svc/topstories/v2/world.json?api-key=GN7xG14Z40flVnMsFydHD7FKm4LpDwhJ');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['num_results']);
      List<TopStoriesModel> topStories = [];

      List results = data['results'];
      results.forEach((element) {
        if (element['multimedia'] != null) {
          topStories.add(TopStoriesModel.fromJson(element));
        }
      });
      return topStories;
    } else {
      print('\nresponse code is not OK - \n');
      print(response.statusCode);
      return null;
    }
  }
}
