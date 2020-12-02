
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/model/article.dart';

import 'package:newsapp/model/categorymodel.dart';
import 'package:newsapp/view/article_view.dart';
import 'package:newsapp/view/category.dart';
class Home extends StatefulWidget{
_HomeState createState()=>_HomeState();

}
class _HomeState extends State<Home>{
  List<Categoriesmodel> category= new List<Categoriesmodel>();
  List<Article> article=new List<Article>();
  bool loading =true;
    @override
  void initState() {
    super.initState();
    category= getCategories();
   getNews();

  }
  void  getNews() async{

     News newss = News();
    await newss.getnews();
     article=newss.news;
    
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
        elevation: 0.0,    ),
        body:loading ? Center(
          child:Container(
            child:CircularProgressIndicator()))
        :SingleChildScrollView(child:Container(
          padding: EdgeInsets.symmetric(horizontal:10),
          child: Column(
          children: <Widget>[   
            Container(
              
              height: 70,
             child: ListView.builder(
                scrollDirection: Axis.horizontal,
                 itemCount: category.length, 
                 shrinkWrap: true,
                 itemBuilder: (context,index){
                   return Categorytile(
                     imgname:category[index].categorieName,
                     imgurl: category[index].imageAssetUrl, );    
                            }
             ),
          ),
          SizedBox(height:15),
          Container(     
          child:ListView.builder(
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
               }),
         )         
          ],
          )
        )
  ));

}
}
class Categorytile extends  StatelessWidget
{
  final String imgurl;
final String imgname;
Categorytile({this.imgname,this.imgurl});
 @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Category(category:imgname.toLowerCase())

        ));
      },
      child: Container(
      margin: EdgeInsets.only(right:19),
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
             child: CachedNetworkImage(imageUrl:imgurl,height:60,width:120,fit:BoxFit.cover))
         ,Container(
           alignment: Alignment.center,
           height:60,width:120,
           decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
           color:Colors.black26  ),
    child:Text(imgname,style:TextStyle(color:Colors.white,  fontSize: 14,fontWeight: FontWeight.w500)))
        ],)));
  }
}

class Blogtile extends StatelessWidget
{
  final String imgUrl,title,desc,url;
  Blogtile({@required this.desc,@required this.imgUrl,@required this.title,this.url});
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>ArticleView(blogUrl: url)))
;
      },
      child: Container(
      margin: EdgeInsets.only(bottom:10),
       child:Column(children: <Widget>[
         ClipRRect(borderRadius:BorderRadius.circular(6),
           child:Image.network(imgUrl),),
         SizedBox(height:10),
         Text(title,style: TextStyle(fontSize:17,color:Colors.black87,fontWeight: FontWeight.w500),),
         SizedBox(height: 10),
         Text(desc,style:TextStyle(color:Colors.black54)),
         SizedBox(height: 15,)
       ],)

    ),
    );
  }


}