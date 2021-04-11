import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsapp_api/services/api_service.dart';

import '../constants.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController messageText = TextEditingController();
  final TextEditingController numberText = TextEditingController();

  String countryCode = "+91";

  /// getting reference to the quickMessagesBox
  var quickMessagesDataBox = Hive.box(quickMessagesBoxName);

  @override
  void initState() {
    super.initState();

    /// getting reference to the basicSettingsBox
    var basicSettingsDataBox = Hive.box(basicSettingsBoxName);

    /// checking if first time.
    if (basicSettingsDataBox.get("isFirstTime", defaultValue: false)) {
      print(basicSettingsDataBox.get("isFirstTime",
          defaultValue: "printing this"));

      /// if the app is opened for the first time
      /// adding some dummy quickMessages in the quickMessagesBox for the user to use
      addSomePreMadeMessages();
    }
  }

  addSomePreMadeMessages() {
    quickMessagesDataBox.put(0, "Hey ");
    quickMessagesDataBox.put(1, "Hello 👋 ");
    quickMessagesDataBox.put(2, "This is my whatsapp ");
    quickMessagesDataBox.put(3, "Text me here ");
    // we can also use the .add method as well
    quickMessagesDataBox.add("Hola 🤠");
  }

  @override
  Widget build(BuildContext context) {
    /// storing device height and width in variables for responsiveness.
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),

                /// Country Code and Mobile Number input fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Country Code Picker
                    Container(
                      width: 120,
                      height: 70,
                      padding: EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      // Added Internationalization
                      child: Center(
                        child: CountryCodePicker(
                          backgroundColor: Colors.black12,
                          dialogBackgroundColor: Colors.black,
                          barrierColor: Colors.white54,
                          dialogTextStyle: TextStyle(color: Colors.white),
                          searchStyle: TextStyle(
                            color: Colors.white,
                          ),
                          closeIcon: Icon(Icons.close, color: Colors.redAccent),
                          searchDecoration: InputDecoration(
                              hintText: 'search',
                              hintStyle: TextStyle(color: Colors.white70)),
                          onChanged: (newValue) {
                            countryCode = newValue.toString();
                          },
                          showFlag: false,
                          showFlagDialog: true,
                          showDropDownButton: true,
                          dialogSize:
                              Size(deviceWidth * 0.8, deviceHeight * 0.4),
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: '+91',
                          favorite: ['+91', '+92'],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),

                    /// Mobile Number TextField
                    Container(
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: numberText,
                        maxLines: 1,
                        maxLength: 10,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        decoration: InputDecoration(
                            hintText: 'number',
                            hoverColor: Colors.black26,
                            border: InputBorder.none,
                            // hiding the counter
                            counterStyle: TextStyle(height: double.minPositive),
                            counterText: ''),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                /// message body textField
                Container(
                  width: deviceWidth > 700 ? 600 : deviceWidth * 0.8,
                  height: deviceHeight * 0.3,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: messageText,
                    minLines: 1,
                    maxLines: null,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'enter your message here',
                      border: InputBorder.none,
                      hoverColor: Colors.white38,
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),

                /// QuickMessages
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box(quickMessagesBoxName).listenable(),
                    builder: (context, Box items, _) {
                      return Container(
                        width: deviceWidth > 700 ? 600 : deviceWidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.white54),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: quickMessagesDataBox.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    messageText.text = messageText.text +
                                        " " +
                                        quickMessagesDataBox
                                            .getAt(index)
                                            .toString();
                                  },
                                  onLongPress: () {
                                    /// on long press the selected QuickMessage gets deleted
                                    quickMessagesDataBox.deleteAt(index);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Chip(
                                      label: Text(quickMessagesDataBox
                                          .getAt(index)
                                          .toString()),
                                    ),
                                  ),
                                );
                              },
                            ),

                            /// add icon
                            /// on tap of this icon we will show a dialog to add a new quickMessage to the QuickMessagesBox
                            IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final TextEditingController
                                      newQuickMessageController =
                                      TextEditingController();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                            backgroundColor:
                                                Colors.blueGrey[100],
                                            child: Container(
                                              padding: EdgeInsets.all(16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  TextField(
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "new quick message"),
                                                    controller:
                                                        newQuickMessageController,
                                                  ),
                                                  FlatButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    color: Colors.red,
                                                    child: Text(
                                                      "Add",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),

                                                    /// on press the selected QuickMessage gets added
                                                    onPressed: () {
                                                      final String quickie =
                                                          newQuickMessageController
                                                              .text;
                                                      newQuickMessageController
                                                          .clear();
                                                      quickMessagesDataBox
                                                          .add(quickie);
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ));
                                      });
                                }),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),

                /// Send Message Button
                FittedBox(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    hoverColor: Colors.lightGreenAccent,
                    color: Colors.green[300],
                    focusColor: Colors.lightGreenAccent,
                    onPressed: () {
                      /// We can separate the Details checking part in a method as well
                      /// for ease i am doing this all within this onTap method
                      if (countryCode == null ||
                          messageText.text == null ||
                          numberText.text == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Empty Fields !!"),
                          duration: Duration(seconds: 3),
                        ));
                      } else if (numberText.text.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Wrong Number - length is shorter than 8 !!"),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        WhatsAppAPIService().sendMessage(countryCode,
                            int.parse(numberText.text), messageText.text);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 5, right: 10, top: 3, bottom: 1),
                          height: 28,
                          width: 28,
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/icon_whatsapp.png',
                            fit: BoxFit.scaleDown,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Send",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
