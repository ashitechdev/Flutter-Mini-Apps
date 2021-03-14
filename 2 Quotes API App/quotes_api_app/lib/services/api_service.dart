import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quotes_api_app/models/quotemodel.dart';

class APIService {
  Future get10RandomQuotes() async {
    List<QuoteModel> newQuotes = [];

    for (int i = 0; i < 10; i++) {
      var response = await http.get("https://api.quotable.io/random");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        newQuotes.add(QuoteModel.fromJson(data));
      } else
        print(response.statusCode);
    }
    return newQuotes;
  }
}
