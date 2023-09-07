import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_photography_app/models/User.dart';
import 'package:flutter_photography_app/models/Collocation.dart';
import 'package:flutter_photography_app/helper/Colorsys.dart';

class SingleUser extends StatefulWidget {
  final User? user;
  const SingleUser({super.key, this.user});

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorsys.lightGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.grey,
        ),
        actions: [
          IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.more_horiz, size: 25, color: Colorsys.grey))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  color: Colors.white
                ),
                child: Column(
                  children: [
                    Hero(
                        transitionOnUserGestures: true,
                        tag: widget.user!.username,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(widget.user!.profilePicture),
                          maxRadius: 40,
                        ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.user!.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.user!.username,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _makeFollowWidget(
                          count: widget.user!.followers,
                          name: 'Followers'
                        ),
                        Container(
                          width: 2,
                          height: 15,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          color: Colorsys.lightGrey,
                        ),
                        _makeFollowWidget(
                            count: widget.user!.following,
                            name: 'Following'
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _makeActionButton()
                  ],
                ),
              ),
            const SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Collotion',
                              style: TextStyle(
                                  color: Colorsys.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 3,
                              width: 40,
                              color: Colorsys.orange,
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Likes',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
            ),
            _makeCollocation(widget.user!.collocation),
          ],
        ),
      ),
    );
  }

  Widget _makeCollocation(List<Collocation> collocation) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: 320,
            child: ListView.builder(
              shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: collocation.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding:  const EdgeInsets.only(left: 20),
                    child: AspectRatio(
                        aspectRatio: 1.2/1,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(collocation[index].thumbnail),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              collocation[index].name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              collocation[index].tags.length.toString() + " photos",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                fontWeight: FontWeight.w300
                                              ),
                                            ),

                                          ],

                                        ),

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            height: 32,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: collocation[index].tags.length,
                              itemBuilder: (context, tagIndex) => Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colorsys.grey300
                                ),
                                child: Center(
                                  child: Text(collocation[index].tags[tagIndex], style: const TextStyle(
                                  ),),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _makeActionButton() {
    return Transform.translate(
      offset: const Offset(0,20),
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 20,
              offset: const Offset(0,10)
            )
          ]
        ),
        child: Row(
          children: [
            Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  elevation: 0,
                  height: double.infinity,
                  onPressed: () {},
                  color: Colorsys.orange,
                  child: const Text('Follow',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                )
            ),
            Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  elevation: 0,
                  height: double.infinity,
                  onPressed: () {},
                  color: Colors.white,
                  child: const Text('Message',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _makeFollowWidget({count, name}) {
    return Row(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(width: 5),
        Text(
          name,
          style: const TextStyle(
              fontSize: 15,
            color: Colors.grey,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }
}
