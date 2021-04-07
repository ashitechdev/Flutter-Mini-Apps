import 'dart:convert';

import 'package:flutter_weather_api_app/models/weather_data_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<dynamic> getBasicDataByCity(String city) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=c847913a01caff9f6e39cc7ad382a3e7&units=metric';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataInJson = jsonDecode(response.body);
      return WeatherDataModel.fromJson(dataInJson);
    } else {
      print('\n\nresponse is not okay\n\n');
      print(response.statusCode);
      return null;
    }
  }

  /// TODO: try out other APIs available on api.openweathermap.org

}
