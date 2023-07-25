 import 'dart:convert';

import 'package:news/models/article_response_dm.dart';

import '../models/SourcesResponse.dart';
 import 'package:http/http.dart' as http;



abstract class ApiManager{
  static const baseUrl="newsapi.org";
  static const apiKey="4e5b3706225c495cabc35548778763a5";

  static Future<SourcesResponseDM> getSources(String categoryId)async {
    Uri url = Uri.https(baseUrl,"v2/top-headlines/sources",{"apiKey":apiKey,
    "category":categoryId}
        );
    http.Response response=await http.get(url);
    Map json=jsonDecode(response.body)as Map;
    print("sourceResponcedm:${json}");
    SourcesResponseDM sourceResponse=SourcesResponseDM.fromJson(json);
    if(sourceResponse.message !=null){
      throw Exception(sourceResponse.message);
    }
    return sourceResponse;
  }
  static Future<ArticlesResponseDm> getArticles(
      {String? sourceId, String? searchKeyWord,int? pageNumper})async {
    Uri url = Uri.https(baseUrl,"v2/everything",
        {"apiKey":apiKey,
          "Sources":sourceId,
      "q":searchKeyWord,
      "pageSize":"20",
      "page":"$pageNumper"}
    );
    http.Response response=await http.get(url);
    Map json=jsonDecode(response.body)as Map;
    print("articlesResponseDM:${response.body}");

    ArticlesResponseDm articleResponse=ArticlesResponseDm.fromJson(json);
    if(articleResponse.message !=null){
      throw Exception(articleResponse.message);
    }
    return articleResponse;
  }

}