import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictok_clone/features/authentication/widgets/form_button.dart';

void main() {
  group("Form Button Tests", () {
    testWidgets("Enabled State", (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormButton(
              disabled: false,
              onTap: () {},
              text: "Test",
            ),
          ),
        ),
      );

      // 애니메이션이 끝날 때까지 기다리기
      await tester.pumpAndSettle();

      expect(find.text("Test"), findsOneWidget);
      // 버튼의 실제 색상 가져오기
      final textStyle = tester
          .firstWidget<AnimatedDefaultTextStyle>(
          find.byType(AnimatedDefaultTextStyle))
          .style;

      // 현재 적용된 색상을 출력해 확인
      print("Actual text color: ${textStyle.color}");

      expect(textStyle.color, Colors.white); // 필요하면 여기 색상을 수정
    });

    testWidgets("Disabled State", (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormButton(
              disabled: true,
              onTap: () {},
              text: "Test",
            ),
          ),
        ),
      );
      // 애니메이션이 끝날 때까지 기다리기
      await tester.pumpAndSettle();

      expect(find.text("Test"), findsOneWidget);
      // 버튼의 실제 색상 가져오기
      final textStyle = tester
          .firstWidget<AnimatedDefaultTextStyle>(
          find.byType(AnimatedDefaultTextStyle))
          .style;

      // 현재 적용된 색상을 출력해 확인
      print("Actual text color: ${textStyle.color}");

      expect(textStyle.color, Colors.grey.shade400); // 필요하면 여기 색상을 수정
    });


  });
}
