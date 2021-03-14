import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/viewmodels/homepage_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // initially adding quotes to the RandomQuotesList
    Provider.of<QuotesData>(context, listen: false).updateRandomQuotesList();

    // initializing scroll controller... so whenever the user is in the end of
    // the screen... more quotes will be fetched and added to the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // adding more quotes to the RandomQuotesList
        Provider.of<QuotesData>(context, listen: false)
            .updateRandomQuotesList();
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var dataProvider = Provider.of<QuotesData>(context, listen: true);
    return Consumer<QuotesData>(builder: (context, datamodel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "  \" Quotes \" ",
            textScaleFactor: 2.0,
            style: GoogleFonts.dancingScript(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: Container(
          child: datamodel.randomQuotesList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,

                  /// this scrollController is a key feature
                  /// it will notify us about users activity and will fetch more quotes
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,

                    /// lets change layout according to mobile,table and desktop
                    crossAxisCount: size.width < 700
                        ? 1
                        : size.width < 1000
                            ? 2
                            : size.width < 1200
                                ? 3
                                : 4,
                  ),
                  itemCount: datamodel.randomQuotesList.length,
                  itemBuilder: (context, index) {
                    if (index == datamodel.randomQuotesList.length - 1) {
                      return Container(
                          margin: EdgeInsets.all(25),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          alignment: Alignment.center,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                    } else {
                      return Container(
                        margin: EdgeInsets.all(25),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.black26)),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " \"${datamodel.randomQuotesList[index].content}\" ",
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                " - ${datamodel.randomQuotesList[index].author} ",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.merriweather(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
        )),
      );
    });
  }
}
