import 'dart:convert';

import 'package:newsapp/model/article.dart';
import 'package:http/http.dart' as http;
class News{
  List<Article> news=[];
  
Future<void> getnews() async
{
String url="http://newsapi.org/v2/top-headlines?country=in&apiKey=779cf23056e245d0a7b10f433a6a4433";
var response=await http.get(url);
print("srhbedshrwNRWnerhnrwHWR");
var jsondata=jsonDecode(response.body);

if(jsondata['status']== 'ok'){
  print("jso");
  jsondata['articles'].forEach((element){
    if(element['urlToImage'] != null && element['description'] != null){
      print("sbsf");
            Article article=new Article(
        title:element['title'],author:element['author'],desc:element['description'],url:element['url'],urlToimage:element['urlToImage']
      ,content: element['content'] );
         news.add(article);
    }

  });
}
}
}
class CategoryNews{
  List<Article> news=[];
Future<void> getCategorynews(String category) async
{

String url="http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=779cf23056e245d0a7b10f433a6a4433";
var response=await http.get(url);

var jsondata=jsonDecode(response.body);
print("srhsrjtj");
if(jsondata['status']== 'ok'){
  print("jso");
  jsondata['articles'].forEach((element){
    if(element['urlToImage'] != null && element['description'] != null){
      print("sbsf");
            Article article=new Article(
        title:element['title'],author:element['author'],desc:element['description'],url:element['url'],urlToimage:element['urlToImage']
      ,content: element['content'] );
         news.add(article);
    }

  });
}
}

}