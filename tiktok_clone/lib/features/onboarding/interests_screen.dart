import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/features/onboarding/widgets/interest_button.dart';

import '../../constants/sizes.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final _scrollController = ScrollController();

  bool _showTitle = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    print(_scrollController.offset);
    if (_scrollController.offset > 150) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      if (!_showTitle) return;
      setState(() {
        _showTitle = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: _showTitle ? 1 : 0,
          child: Text(
            "Choose your interests",
            style: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(
                left: Sizes.size24, right: Sizes.size24, bottom: Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v16,
                Text(
                  "Choose your interests",
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v20,
                Text(
                  "Get better video recommendations",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.black45,
                  ),
                ),
                Gaps.v64,
                Wrap(
                  spacing: Sizes.size16,
                  runSpacing: Sizes.size16,
                  children: [
                    for (var interest in interests)
                      InterestButton(
                        interest: interest,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        height: Sizes.size60 * 2,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.size16,
            horizontal: Sizes.size20,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.size20,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Sizes.size20),
            ),
            child: Text(
              'Next',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
