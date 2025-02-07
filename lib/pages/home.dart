import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newser/models/article_model.dart';
import 'package:newser/models/category_model.dart';
import 'package:newser/models/slider_model.dart';
import 'package:newser/pages/article_view.dart';
import 'package:newser/pages/category_news.dart';
import 'package:newser/services/data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:newser/services/news.dart';
import 'package:newser/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List <SliderModel> sliders =[];
  List <ArticleModel> articles = [];
  bool _loading=true;
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getSlider();
    getNews();

  }


  getNews()async{
    News newsclass= News();
    await newsclass.getNews();
    articles= newsclass.news;
    setState(() {
      _loading= false;
    });
  }
  getSlider() async {
    SliderService sliderService = SliderService();
    await sliderService.getSlider();
    sliders = sliderService.slider;
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           // appbar text
            Text("News App", style: TextStyle(color: Colors.blue, fontSize: 30,fontWeight: FontWeight.bold,fontFamily: 'MonomaniacOne-Regular'),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),

      //top 5 categories image and name
      body: _loading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15.0),
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length , itemBuilder: (context, index) {
                return categoryTile(
                  image: categories[index].image,
                  categoryName: categories[index].categoryName,
        
                );
              }
        
              ),
              ),
              SizedBox(height: 30.0,),

              //brekeing news text
              Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   Text("Breaking News!", style: TextStyle(
                       color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),

                 ],
                    ),
              ),
              SizedBox(height: 20.0,),
              // slider
              CarouselSlider.builder(

                  itemCount:5 , itemBuilder: (context, index, realIndex){
                String res= sliders[index].urlToImage ??"images/building.jpg";
                String res1= sliders[index].title ??"no title";
                return buildImage(res!, index, res1!);
              },
                  options: CarouselOptions(
                      height: 250,
                      // viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason){
                        setState(() {
                          activeIndex = index;
                        });
                  }
        
                  )),
              SizedBox(height: 30.0,),
              Center(child:  buildIndicator(),),
              SizedBox(height: 30.0,),
              //Tranding news text
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tranding News!", style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 10.0),
              //tranding news implementation
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return BlogTile(
                      url: articles[index].url ?? "https://via.placeholder.com/150",
                      imageUrl: articles[index].urlToImage ?? "https://via.placeholder.com/150",
                      title: articles[index].title ?? "No Title Available",
                      desc: articles[index].descrption ?? "",
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget buildImage(
      String image, int index, String name) => Container (
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    child: Stack(
      children: [
       ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: image,
          height: 250,
          fit: BoxFit.cover, width: MediaQuery.of(context).size.width,
        ),
      ),
      Container(
        height: 250,
        padding: EdgeInsets.only(left: 10.0),
        margin: EdgeInsets.only(top: 170.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.black26,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)
        ),
        ),
        child: Text(
            name, maxLines: 2, style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)
         ),
      ),
  ],

  ),
  );
  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count:5,
    effect: SlideEffect(dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue),
  );
}
class categoryTile extends StatelessWidget {
  final image, categoryName;
  categoryTile({
    this.image,
    this.categoryName
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(name: categoryName),
        ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child:Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image,
                      width: 120, height: 70,
                fit: BoxFit.cover
                    ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                child: Text(
                  categoryName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
String imageUrl, title, desc, url;
BlogTile({
  required this.imageUrl,
  required this.title,
  required this.desc,
  required this.url
});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView( blogUrl: url)));
      },
      child: Container(

        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding (
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child:Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                          imageUrl: imageUrl,height: 120, width: 120, fit: BoxFit.cover),

                    ),
                  ),
                  SizedBox(width: 8.0),

                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.7,
                        child: Text(title,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17.0),
                        ),
                      ),
                      SizedBox(height: 7.0,),
                      Container(
                        width: MediaQuery.of(context).size.width/1.7,
                        child: Text(desc,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


