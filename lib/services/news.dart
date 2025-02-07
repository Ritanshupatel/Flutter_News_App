import 'dart:convert';

import 'package:newser/models/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List <ArticleModel> news=[];

  Future<void> getNews()async{
    String url='https://newsapi.org/v2/everything?q=tesla&from=2025-01-07&sortBy=publishedAt&apiKey=ea059ca5b0f2462e848ba65cec407414';
    var response = await http.get(Uri.parse(url));

    var jsonData= jsonDecode(response.body);
    if (jsonData['status']=='ok'){
      jsonData['articles'].forEach((element){
        if(element['urlToImage']!=null && element['description']!=null){
          ArticleModel articleModel= ArticleModel(
            title: element['title'],
            descrption: element['descrption'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author'],
          );
          news.add(articleModel);
        }
      }
      );
    }

  }
}