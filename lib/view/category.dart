import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/model/article.dart';

import 'home.dart';
class Category extends StatefulWidget{
  final String category;
  Category({this.category});
_CategoryState createState()=>_CategoryState();

}
class _CategoryState extends State<Category>{
  List<Article> article =new List<Article>();
  bool loading=true;
  @override
  void initState() {
    super.initState();
    getCatgoryNews();
  }
 void  getCatgoryNews() async{
     CategoryNews categorynew = CategoryNews();
    await categorynew.getCategorynews(widget.category);
     article=categorynew.news;
     setState((){
      loading=false;
     });   }
   
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Flutter"),
          Text("News",style:TextStyle(color:Colors.blue) ,)
          ],),
          actions:<Widget>[
            Opacity(opacity: 0,
            child:Container(
              padding:EdgeInsets.symmetric(horizontal:16),
              child:Icon(Icons.save)
              ,))

          ],
          centerTitle: true,
        elevation: 0.0,    ),
        body:  loading ? Center(
          child:Container(
            child:CircularProgressIndicator()))
        :SingleChildScrollView(child:Container(
          padding: EdgeInsets.symmetric(horizontal:10),
        child:Column(children: <Widget>[
           ListView.builder(
            itemCount:article.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
          itemBuilder: (context,index){
            return Blogtile(
              imgUrl: article[index].urlToimage,
              title: article[index].title,
              desc: article[index].desc,
              url:article[index].url
               );
               }),]
         )
        )
  ));
  
}
}