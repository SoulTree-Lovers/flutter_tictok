import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          stretch: true,
          pinned: true,
          backgroundColor: Colors.white,
          collapsedHeight: 80,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            background: Image.network(
              "https://avatars.githubusercontent.com/u/54972879?v=4",
              fit: BoxFit.cover,
            ),
            title: Text(
              "User Profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/54972879?v=4",
                ),
              )
            ],
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                color: Colors.amber[100 * (index % 9)],
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Item $index"),
                ),
              );
            },
            childCount: 50,
          ),
          itemExtent: 100,
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: CustomDelegate(),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                color: Colors.blue[100 * (index % 9)],
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Grid Item $index"),
                ),
              );
            },
            childCount: 50,
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1,
          ),
        ),
      ],
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text("--- Sub Title ---"),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}