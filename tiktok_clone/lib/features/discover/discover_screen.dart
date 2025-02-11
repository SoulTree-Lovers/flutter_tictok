import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/sizes.dart';

import '../../constants/gaps.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Discover"),
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            unselectedLabelColor: Colors.grey.shade600,
            labelColor: Colors.black,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.black,
            tabs: [
              for (final tab in tabs) Tab(text: tab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              padding: EdgeInsets.all(Sizes.size10),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage(
                          "assets/images/image1.png",
                        ),
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1738848392298-cf0b62edc750?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4MHx8fGVufDB8fHx8fA%3D%3D"),
                      ),
                    ),
                    Gaps.v8,
                    Text(
                      "This is a title of the video that is very long and it will be cut off at some point",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size16,
                      ),
                    ),
                    Gaps.v4,
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: Sizes.size12,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: Sizes.size12,
                            backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/54972879?v=4",
                            ),
                          ),
                          Gaps.h8,
                          Expanded(
                            child: Text(
                              "My name is very long and it will be cut off",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gaps.h4,
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size12,
                            color: Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          Text(
                            "2.5M",

                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            for (final tab in tabs.skip(1))
              Center(
                child: Text(tab),
              ),
          ],
        ),
      ),
    );
  }
}
