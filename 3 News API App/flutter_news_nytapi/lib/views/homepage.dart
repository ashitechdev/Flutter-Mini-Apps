import 'package:flutter/material.dart';
import 'package:flutter_news_nytapi/viewmodels/top_stories.dart';
import 'package:flutter_news_nytapi/views/web_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
//    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    Provider.of<TopStories>(context, listen: false).refreshTopStoriesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<TopStories>(context, listen: true).status),
      ),
      body: SafeArea(
        child: Provider.of<TopStories>(context, listen: true)
                .topStoriesNewsList
                .isEmpty
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Provider.of<TopStories>(context, listen: true)
                      .topStoriesNewsList
                      .length,
                  itemBuilder: (context, index) {
                    var data = Provider.of<TopStories>(context, listen: true)
                        .topStoriesNewsList;
                    return Container(
                      child: customListTile(
                          ontap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return WebViewWidget(
                                url: Provider.of<TopStories>(context,
                                        listen: false)
                                    .topStoriesNewsList[index]
                                    .url,
                              );
                            }));
                          },
                          img: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.black54),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      data[index].multimedia[2].url),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          other: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  data[index].title,
                                  maxLines: 3,
                                  textScaleFactor: 1.3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(1),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  data[index].topStoriesModelAbstract ?? '-',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

Widget customListTile({Widget img, Widget other, Function ontap}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: 140,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.black54),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: img,
          ),
          const Padding(
            padding: EdgeInsets.all(4),
          ),
          Expanded(
            flex: 5,
            child: other,
          )
        ],
      ),
    ),
  );
}
