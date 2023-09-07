import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_photography_app/models/Post.dart';
import 'package:flutter_photography_app/helper/Colorsys.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SinglePost extends StatelessWidget {
  final Post? post;
  final String image;

  const SinglePost({Key? key, this.post, required this.image})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 70, bottom: 20, right: 20, left: 20),
              height: screenHeight / 2,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black.withOpacity(0.2)
                          ),
                          child: const Center(
                            child: Icon(
                                Icons.arrow_back_ios, color: Colors.white,
                                size: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 25,
                            backgroundImage: AssetImage(
                                post!.user!.profilePicture),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            post!.user!.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.black.withOpacity(0.1)
                            ),
                            child: Center(
                              child: Image.asset('assets/icons/download.png'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/location.png', scale: 2.2),
                      const SizedBox(width: 5),
                      Text(
                        post!.location,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colorsys.grey
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _makeRelatedPhotos(post!),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }

  Widget _makeRelatedPhotos(Post post) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: post.relatedPhotos!.length,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(post.relatedPhotos![index])
            ),
            color: Colors.green
        ),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 3 : 2),
    );
  }
}
