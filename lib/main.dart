import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_photography_app/helper/Colorsys.dart';
import 'package:flutter_photography_app/data/Sample.dart';
import 'package:flutter_photography_app/models/Post.dart';
import 'package:flutter_photography_app/pages/SinglePost.dart';
import 'package:flutter_photography_app/pages/SingleUser.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorsys.lightGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colorsys.lightGrey,
        leading: IconButton(
          icon: Icon(Icons.menu, size: 30,color: Colorsys.darkGray), onPressed: () {  },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _searchBox(),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("For you", style: TextStyle(
                      color: Colorsys.darkGray,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Recommend',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                              width: 50,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                color: Colorsys.orange,
                                width: 3,
                              ))
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Likes',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 1,
                    color: Colorsys.lightGrey,
                  ),
                  const SizedBox(height: 30),
                  _makePost(Sample.postOne),
                  _makePost(Sample.postTwo),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _makePost(Post post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SingleUser(user: post.user)
              ));
            },
            child: Row(
              children: [
                Hero(
                  transitionOnUserGestures: true,
                    tag: post.user!.username,
                    child: CircleAvatar(
                      maxRadius: 28,
                      backgroundImage: AssetImage(post.user!.profilePicture),
                    ),
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.user!.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(post.location,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey
                              ),
                            ),
                            Text(post.dateAgo,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.only(top: 24),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: post.photos.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SinglePost(post: post, image: post.photos[index])));
                    },
                    child: AspectRatio(
                      aspectRatio: 1.2/1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(post.photos[index]),
                            fit: BoxFit.cover
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                          child: Center(
                                            child: Image.asset('assets/icons/link.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                          child: Center(
                                            child: Image.asset('assets/icons/heart.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text("Best place to \nFind awesome photos",
            style: TextStyle(
              fontSize: 28,
              color: Colorsys.darkGray,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 50,
            padding: const EdgeInsets.only(left: 20, top: 3, right: 3, bottom: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for photo",
                      hintStyle: TextStyle(color: Colorsys.grey),
                      border: InputBorder.none
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  height: double.infinity,
                  minWidth: 50,
                  elevation: 0,
                  color: Colorsys.orange,
                  child: const Icon(Icons.search, color: Colors.white,),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
