import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostCommentScreen extends StatefulWidget {
  const PostCommentScreen({
    super.key,
    required this.post,
  });

  final dynamic post;

  @override
  State<PostCommentScreen> createState() => _PostCommentScreenState();
}

class _PostCommentScreenState extends State<PostCommentScreen> {
  List<dynamic> comments = [];

  @override
  void initState() {
    super.initState();
    getComments();
  }

  Future<void> getComments() async {
    int postId = widget.post['id'];

    final response = await Dio()
        .get("https://jsonplaceholder.typicode.com/posts/$postId/comments");

    comments = response.data;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: Column(
        children: [
          postItem(),
          if (comments.isEmpty)
            const CircularProgressIndicator.adaptive()
          else
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];

                  return Container(
                    margin: EdgeInsets.all(10.sp),
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[400],
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        Text(
                          comment['email'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        Text(
                          comment['body'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget postItem() {
    return Container(
      margin: EdgeInsets.all(10.sp),
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post['title'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.sp),
          Text(
            widget.post['body'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
