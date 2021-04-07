import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_api_app/models/weather_data_model.dart';
import 'package:flutter_weather_api_app/services/api_service.dart';

class HomePageController extends ChangeNotifier {
  WeatherDataModel _weatherData;

  WeatherDataModel get weatherData => _weatherData;

  Statuses status = Statuses.stopped;

  getBasicDataByCityName({@required String city}) async {
    try {
      status = Statuses.trying;
      var data = await APIService().getBasicDataByCity(city);
      if (data == null) {
        status = Statuses.receivedNull;
        notifyListeners();
      } else {
        _weatherData = data;

        status = Statuses.successful;
        notifyListeners();
      }
    } catch (e) {
      status = Statuses.error;
    }
  }
}

enum Statuses { stopped, successful, error, trying, receivedNull }
