import 'package:flutter/material.dart';
import 'package:flutter24/blog/blog.dart';

class EditBlogScreen extends StatefulWidget {
  const EditBlogScreen({
    Key? key,
    required this.blog,
  }) : super(key: key);

  final Blog blog;

  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.blog.title;
    contentController.text = widget.blog.content;
    imageUrlController.text = widget.blog.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Blog"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: "Content",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: imageUrlController,
              decoration: const InputDecoration(
                labelText: "Image URL",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(top: 15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  updateBlog();
                },
                child: const Text(
                  "Update",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateBlog() {
    String title = titleController.text;
    String content = contentController.text;
    String imageUrl = imageUrlController.text;

    final blog = Blog(
      title: title,
      content: content,
      imageUrl: imageUrl,
    );

    Navigator.pop(context, blog);
  }
}
