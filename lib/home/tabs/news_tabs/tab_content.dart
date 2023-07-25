import 'package:flutter/material.dart';
import 'package:news/data/api_manager.dart';
import 'package:news/home/tabs/news_tabs/news_details.dart';
import 'package:news/models/SourcesResponse.dart';
import 'package:news/models/article_response_dm.dart';

class GetTapContent extends StatefulWidget {
  SourcesDM sourceDm;

  GetTapContent(this.sourceDm);

  @override
  State<GetTapContent> createState() => _GetTapContentState();
}

class _GetTapContentState extends State<GetTapContent> {
  int pageNumper = 1;
  final ScrollController _controller = ScrollController();
  bool shouldLoadNextPage = false;
  List<ArticlesDM> newsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (!isTop) {
          shouldLoadNextPage = true;
          setState(() {});
        }
      }
    });
  }

  Widget build(BuildContext context) {
    if (shouldLoadNextPage) {
      ApiManager.getArticles(
              sourceId: widget.sourceDm.id!, pageNumper: ++pageNumper)
          .then((ArticlesResponseDm) {
        newsList.addAll(ArticlesResponseDm.articles ?? []);
        shouldLoadNextPage = false;
        setState(() {});
      });
             
    }
    return FutureBuilder<ArticlesResponseDm>(
      future: ApiManager.getArticles(
        sourceId: widget.sourceDm.id!,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          if (newsList.isEmpty) {
            newsList = snapshot.data?.articles ?? [];
          } else if (newsList.first.title !=
              snapshot.data?.articles?.first.title) {
            newsList = snapshot.data?.articles ?? [];
            _controller.jumpTo(0);
          }
          return ListView.builder(
            itemCount: newsList.length,
            controller: _controller,
            itemBuilder: (context, index) {
              print(index);
              return buildNewsWidget(context, newsList[index]);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget buildNewsWidget(BuildContext context, ArticlesDM article) {
  return InkWell(
    onTap: () => Navigator.pushNamed(context, NewsDtailsScreen.routeName,
        arguments: article),
    child: Container(
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
          SizedBox(
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
  );
}
