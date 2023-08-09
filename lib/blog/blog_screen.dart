import 'package:flutter/material.dart';
import 'package:flutter24/blog/add_blog_screen.dart';
import 'package:flutter24/blog/blog.dart';
import 'package:flutter24/blog/edit_blog_screen.dart';
import 'package:flutter24/blog/story_view_screen.dart';
import 'package:flutter24/utils/app_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final String imageUrl =
      "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80";

  final String name = "Amir Mohammed";

  // blogs[1].title
  // 0 => Blog(title, content, imageUrl);
  // 1 => Blog(title, content, imageUrl);
  // 2 => Blog(title, content, imageUrl);
  List<Blog> blogs = [
    Blog(
      title: "Piano",
      content:
          "a large keyboard musical instrument with a wooden case enclosing a soundboard and metal strings, which are struck by hammers when the keys are depressed. The strings' vibration is stopped by dampers when the keys are released and can be regulated for length and volume by two or three pedals.",
      imageUrl:
          "https://cdn1.img.sputnikarabic.ae/img/104012/71/1040127161_0:171:4032:2439_600x0_80_0_0_bf877107b21a7dab90c7ce76c503464d.jpg",
    ), // 0
    Blog(
      title: "Titanic submarine",
      content:
          "Missing Titanic submarine LIVE: Can bodies be retrieved after implosion? Experts weigh in",
      imageUrl:
          "https://phantom-marca.unidadeditorial.es/e78616bbda77fe6fbc6b1ed5a05d3232/resize/828/f/webp/assets/multimedia/imagenes/2023/06/21/16873550466244.png",
    ), // 1
    Blog(
      title: "Customization Cars",
      content:
          "Two Customized Cars Rolling Through A City Street Photo Photo of two customized cars on a city side street. One car is raised up and the other is very low.",
      imageUrl:
          "https://burst.shopifycdn.com/photos/two-customized-cars-rolling-through-a-city-street.jpg",
    ), // 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddBlogScreen(),
        backgroundColor: blogs.length > 1 ? Colors.white : Colors.blueGrey,
        child: Icon(
          Icons.add,
          color: blogs.length > 1 ? Colors.blueGrey : Colors.white,
          size: 16.sp,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 45.sp,
            child: ListView.builder(
              itemCount: 8,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StoryViewScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.sp),
                              child: AppImage(
                                imageUrl: imageUrl,
                                width: 35.sp,
                                height: 35.sp,
                                fit: BoxFit.fill,
                              ),
                            ),
                            CircleAvatar(
                              radius: 13.sp,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 12.sp,
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        name.length > 8 ? "${name.substring(0, 8)}.." : name,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                return blogItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget blogItem(int index) {
    Blog blog = blogs[index];

    return Container(
      margin: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.sp),
              topLeft: Radius.circular(15.sp),
            ),
            child: AppImage(
              imageUrl: blog.imageUrl,
              height: 25.h,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            // Image.network(
            //   blog.imageUrl,
            //   height: 25.h,
            //   width: double.infinity,
            //   fit: BoxFit.fill,
            // ),
          ),
          SizedBox(height: 10.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    blog.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    navigateToEditBlogScreen(index);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 10.sp),
                IconButton(
                  onPressed: () {
                    blogs.removeAt(index);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 10.sp),
              ],
            ),
          ),
          SizedBox(height: 15.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Text(
              blog.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 15.sp),
        ],
      ),
    );
  }

  navigateToAddBlogScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddBlogScreen(),
      ),
    ).then((value) {
      if (value == null) return;

      blogs.add(value);
      setState(() {});
    });
  }

  navigateToEditBlogScreen(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBlogScreen(
          blog: blogs[index],
        ),
      ),
    ).then((value) {
      if (value == null) return;

      // blogs.add(value);
      blogs[index] = value;
      setState(() {});
    });
  }
}
