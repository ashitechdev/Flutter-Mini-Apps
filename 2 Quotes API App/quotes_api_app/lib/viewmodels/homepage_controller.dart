import 'package:flutter/cupertino.dart';
import 'package:quotes_api_app/models/quotemodel.dart';
import 'package:quotes_api_app/services/api_service.dart';

class QuotesData with ChangeNotifier {
  List<QuoteModel> randomQuotesList = [];

  updateRandomQuotesList() async {
    List<QuoteModel> latestQuotes = await APIService().get10RandomQuotes();
    if (latestQuotes != null) {
      if (randomQuotesList.length > 1) {
        randomQuotesList.addAll(latestQuotes);
      } else {
        randomQuotesList = latestQuotes;
      }
      notifyListeners();
    } else {
      print("latest quotes was null");
    }
  }
}
