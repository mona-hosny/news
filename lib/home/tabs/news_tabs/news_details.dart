

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../models/article_response_dm.dart';

class NewsDtailsScreen extends StatelessWidget {
  static String routeName = "news_details";

  @override
  Widget build(BuildContext context) {
    var article = ModalRoute.of(context)!.settings.arguments as ArticlesDM;
    return Scaffold(appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          height: MediaQuery.of(context).size.height * 0.25,
                          article.urlToImage ??
                              "https://www.gettyimages.com/detail/illustration/abstract-globe-background-royalty-free-illustration/1311148884?adppopup=true",
                          fit: BoxFit.fill),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  article.author ?? "",
                ),
                Text(article.title ?? ""),
                Text(article.publishedAt ?? "")
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(article.description ?? ""),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {
                lanchUrlNews(article.url);
              },
                child: Text(
                  "view all article",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.arrow_forward)
            ],
          )
        ],
      ),
    );
  }
  Future<void>lanchUrlNews(String?url)async{
    if(url==null)return;
    var uri=Uri.parse(url);
    if (await canLaunchUrl(uri)){
      launchUrl(uri);
    }

  }
}
