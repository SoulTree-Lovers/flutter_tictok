import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/breakpoints.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    // 컨트롤러 초기화
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _tabController = TabController(length: tabs.length, vsync: this);

    // 탭 변경 시 검색창 포커스 해제
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        FocusScope.of(context).unfocus();
      }
    });

    // 스크롤 시 키보드 닫기
    _scrollController.addListener(() {
      if (FocusScope.of(context).hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onClearTap() {
    _searchController.clear();
  }

  void _onSearchChanged(String value) {
    print("Search changed: $value");
  }

  void _onSearchSubmitted(String value) {
    print("Search submitted: $value");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print("Width: $width");

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: FaIcon(FontAwesomeIcons.sliders),
            ),
            Gaps.h10,
          ],
          title: CupertinoSearchTextField(
            onChanged: _onSearchChanged,
            onSubmitted: _onSearchSubmitted,
            controller: _searchController, // ✅ TextEditingController 적용
          ),
          bottom: TabBar(
            controller: _tabController,  // ✅ TabController 적용
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            unselectedLabelColor: Colors.grey.shade600,
            labelColor: Colors.black,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.black,
            tabs: [for (final tab in tabs) Tab(text: tab)],
          ),
        ),
        body: TabBarView(
          controller: _tabController, // ✅ TabController 적용
          children: [
            // ✅ ScrollController와 Scrollbar를 함께 적용
            Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: GridView.builder(
                controller: _scrollController, // ✅ ScrollController 적용
                padding: EdgeInsets.all(Sizes.size10),
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 9 / 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4),
                        ),
                        child: AspectRatio(
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
            ),
            for (final tab in tabs.skip(1))
              Center(child: Text(tab)),
          ],
        ),
      ),
    );
  }
}
