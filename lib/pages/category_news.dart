import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newser/models/show_category.dart';
import 'package:newser/pages/article_view.dart';
import 'package:newser/services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  final String name;

  const CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryeModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ShowCategory(
            imageUrl: categories[index].urlToImage ?? "https://via.placeholder.com/150",
            title: categories[index].title ?? "No Title Available",
            desc: categories[index].descrption ?? "No description Available",
            url: categories[index].url ?? "",
          );
        },
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String url;

  const ShowCategory({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              maxLines: 3,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
