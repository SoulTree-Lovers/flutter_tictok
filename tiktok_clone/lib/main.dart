import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictok_clone/features/authentication/sign_up_screen.dart';
import 'package:tictok_clone/features/discover/discover_screen.dart';
import 'package:tictok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tictok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tictok_clone/features/videos/inbox/activity_screen.dart';
import 'constants/sizes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화
  await SystemChrome.setPreferredOrientations( // 세로 모드로 고정
    [
      DeviceOrientation.portraitUp,
    ],
  );
  
  SystemChrome.setSystemUIOverlayStyle( // 시스템 UI 오버레이 스타일 설정 (와이파이, 배터리, 시계 등)
    SystemUiOverlayStyle.dark,
  );
  
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok',
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFFE9435A),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          elevation: 0.5,
          shadowColor: Colors.grey,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: MainNavigationScreen(),
    );
  }
}


class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width / 2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Colors.blue,
              child: Center(
                child: Text("Width: ${size.width} / ${constraints.maxWidth}, Height: ${constraints.maxHeight}", style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),),
              ),
            );
          },
        ),
      ),
    );
  }
}
