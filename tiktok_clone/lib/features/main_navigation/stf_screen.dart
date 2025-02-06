import 'package:flutter/material.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({super.key});

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int _clicks = 0;

  void _increase() {
    setState(() {
      _clicks++;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("clicked $_clicks times");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You clicked $_clicks times"),
          TextButton(
            onPressed: _increase,
            child: Text("+"),
          ),
        ],
      ),
    );
  }
}
