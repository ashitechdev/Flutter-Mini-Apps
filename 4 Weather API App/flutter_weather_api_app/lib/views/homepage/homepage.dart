import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_api_app/controllers/homepage_controller.dart';
import 'package:flutter_weather_api_app/models/weather_data_model.dart';
import 'package:flutter_weather_api_app/views/common_widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// TODO: change the Title to some appropriate Text 😆
        title: Text(Provider.of<HomePageController>(context).status.toString()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFCEACA7), Color(0xFF4968A3)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
          child: Column(
            children: [
              /// TextField
              Container(
                margin: EdgeInsets.fromLTRB(2, 5, 2, 10),
                padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black12)),
                child: Center(
                  child: TextField(
                    controller: _textEditingController,
                    autofocus: true,
                    style: TextStyle(fontSize: 20),

                    /// how about extracting this into a _onTap method so that this code snippet can be reused at line: 66
                    onSubmitted: (_) {
                      if (_textEditingController.text.isNotEmpty &&
                          _textEditingController.text != null) {
                        Provider.of<HomePageController>(context, listen: false)
                            .getBasicDataByCityName(
                                city: _textEditingController.text);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Fetching Articles"),
                          backgroundColor: Colors.yellow[100],
                        ));
                        FocusScope.of(context).unfocus();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Empty Fields !!"),
                          backgroundColor: Colors.red[100],
                        ));
                      }
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                        prefixText: '  ',
                        border: InputBorder.none,
                        hintText: 'Chandigarh',
                        suffix: IconButton(
                          icon: Icon(Icons.search_sharp),
                          onPressed: () {
                            if (_textEditingController.text.isNotEmpty &&
                                _textEditingController.text != null) {
                              Provider.of<HomePageController>(context,
                                      listen: false)
                                  .getBasicDataByCityName(
                                      city: _textEditingController.text);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Fetching Articles"),
                                backgroundColor: Colors.yellow[100],
                              ));
                              FocusScope.of(context).unfocus();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Empty Fields !!"),
                                backgroundColor: Colors.red[100],
                              ));
                            }
                          },
                        )),
                  ),
                ),
              ),

              /// getting a widget based on the status of data in homepage_controller
              getProperWidget(
                  context,
                  Provider.of<HomePageController>(context, listen: true)
                      .status),
            ],
          ),
        ),
      ),
    );
  }

  /// returns a widget based on status of data in homepage_controller
  Widget getProperWidget(context, Statuses _status) {
    /// TODO: how about making it a switch case instead of if-Else

    /// when status == Stopped
    if (_status == Statuses.stopped) {
      return Padding(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: Text("Search by City Name to fetch data :)"));
    }

    /// when status == Trying
    else if (_status == Statuses.trying) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Fetching Data'),
          ),
          CircularProgressIndicator()
        ],
      );
    }

    /// when status == Received null from API
    else if (_status == Statuses.receivedNull) {
      return Column(
        children: [
          Text("received NULL :("),
          Text("Try Checking City name Again"),
          Text("OR"),
          FlatButton(
            child: Text("Try Again"),
            color: Colors.black12,
            onPressed: () {
              if (_textEditingController.text.isNotEmpty &&
                  _textEditingController.text != null) {
                Provider.of<HomePageController>(context, listen: false)
                    .getBasicDataByCityName(city: _textEditingController.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Fetching Articles"),
                  backgroundColor: Colors.yellow[100],
                ));
                FocusScope.of(context).unfocus();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Empty Fields !!"),
                  backgroundColor: Colors.red[100],
                ));
              }
            },
          )
        ],
      );
    }

    /// when status == Error
    else if (_status == Statuses.error) {
      return Column(
        children: [
          Text("Error - Check Connection"),
          FlatButton(
            child: Text("Try Again"),
            onPressed: () {
              if (_textEditingController.text.isNotEmpty &&
                  _textEditingController.text != null) {
                Provider.of<HomePageController>(context, listen: false)
                    .getBasicDataByCityName(city: _textEditingController.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Fetching Articles"),
                  backgroundColor: Colors.yellow[100],
                ));
                FocusScope.of(context).unfocus();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Empty Fields !!"),
                  backgroundColor: Colors.red[100],
                ));
              }
            },
          )
        ],
      );
    }

    /// finally when status == Successful
    else if (_status == Statuses.successful) {
      return showBasicDataContainer(
          data: Provider.of<HomePageController>(context).weatherData);
    } else
      return CircularProgressIndicator();
  }
}

/// returns basic Data Container widget when the status of data is successful in homepage_controller
Widget showBasicDataContainer({@required WeatherDataModel data}) {
  return Container(
    child: BlurryContainer(
      blur: 5,
      padding: EdgeInsets.all(5),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Column(
        children: [
          SizedBox(height: 20),
          BlurryContainer(
            bgColor: Colors.lightBlueAccent[100],
            blur: 3,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Temperature"),
                Text(":"),
                Text(data.main.temp.toString() + " C"),
              ],
            ),
          ),
          SizedBox(height: 10),
          BlurryContainer(
            bgColor: Colors.lightBlueAccent[100],
            blur: 3,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Minimum Temperature"),
                Text(":"),
                Text(data.main.tempMin.toString() + " C"),
              ],
            ),
          ),
          SizedBox(height: 10),
          BlurryContainer(
            bgColor: Colors.lightBlueAccent[100],
            blur: 3,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Maximum Temperature"),
                Text(":"),
                Text(data.main.tempMax.toString() + " C"),
              ],
            ),
          ),
          SizedBox(height: 10),
          BlurryContainer(
            bgColor: Colors.lightBlueAccent[100],
            blur: 3,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weather Condition"),
                Text(":"),
                Text(data.weather[0].main.toString()),
              ],
            ),
          ),
          SizedBox(height: 10),
          BlurryContainer(
            bgColor: Colors.lightBlueAccent[100],
            blur: 3,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weather Condition Description"),
                Text(":"),
                Text(data.weather[0].description.toString()),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    ),
  );
}
