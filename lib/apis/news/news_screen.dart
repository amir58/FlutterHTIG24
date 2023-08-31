import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/apis/news/article_webview.dart';
import 'package:flutter24/apis/news/models/NewsResponse.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsResponse newsResponse = NewsResponse();

  @override
  void initState() {
    super.initState();
    getNews(country: "eg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News")),
      body: newsResponse.articles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: newsResponse.articles.length,
              itemBuilder: (context, index) {
                Articles article = newsResponse.articles[index];

                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleWebview(
                        articleUrl: article.url,
                      ),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(15.sp),
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Text(article.title),
                  ),
                );
              },
            ),
    );
  }

  void getNews({required String country}) async {
    // final response = Dio().get("https://newsapi.org/v2/top-headlines?country=sa&category=technology&apiKey=f658f070236f414194e11fc3023c8333");

    final response = await Dio().get(
      "https://newsapi.org/v2/top-headlines",
      queryParameters: {
        "apiKey": "f658f070236f414194e11fc3023c8333",
        "country": country,
        "category": "technology",
      },
    );

    newsResponse = NewsResponse.fromJson(response.data);

    setState(() {});
  }
}
