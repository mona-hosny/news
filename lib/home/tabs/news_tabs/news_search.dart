import 'package:flutter/material.dart';

import '../../../data/api_manager.dart';
import '../../../models/article_response_dm.dart';
import 'news_details.dart';

class NewsSearch extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[IconButton(onPressed: () {showResults(context);

    }, icon: const Icon(Icons.search,size: 25,))] ;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {Navigator.pop(context);

    }, icon: const Icon(Icons.close,size: 25,));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<ArticlesResponseDm>(
      future: ApiManager.getArticles(searchKeyWord: query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.articles!.length,

            itemBuilder: (context, index) {

              return buildNewsWidget(context,snapshot.data!.articles![index]);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return Center(child: const Text("search now",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),));
    }
  return
    FutureBuilder<ArticlesResponseDm>(
      future: ApiManager.getArticles(searchKeyWord: query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.articles!.length,

            itemBuilder: (context, index) {

              return buildNewsWidget(context,snapshot.data!.articles![index]);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget buildNewsWidget(BuildContext context,ArticlesDM article) {
  return InkWell(onTap: () => Navigator.pushNamed(context, NewsDtailsScreen.routeName,arguments:article),
    child: Container(padding: EdgeInsets.all(10),margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(alignment: Alignment.center,
            children: [CircularProgressIndicator(),
              ClipRRect(borderRadius: BorderRadius.circular(10),
                child: Image.network(height: MediaQuery.of(context).size.height*0.25,article.urlToImage ??
                    "https://www.gettyimages.com/detail/illustration/abstract-globe-background-royalty-free-illustration/1311148884?adppopup=true",fit: BoxFit.fill),
              ),
            ],
          ),SizedBox(height: 5,),
          Text(article.author??"",),
          Text(article.title??""),
          Text(article.publishedAt??"")
        ],
      ),
    ),
  );
  }