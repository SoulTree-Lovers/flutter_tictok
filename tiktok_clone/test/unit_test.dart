// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictok_clone/features/videos/models/video_model.dart';

import 'package:tictok_clone/main.dart';

void main() {

  group("Video Model Test", () {
    test('Test Video Model Construct', () {
      final video = VideoModel(
        id: "id",
        title: "title",
        description: "description",
        fileUrl: "fileUrl",
        thumbnailUrl: "thumbnailUrl",
        creatorUid: "creatorUid",
        creatorName: "creatorName",
        likes: 1,
        comments: 1,
        createdAt: 1,
      );

      expect(video.id, "id");
    });

    test('Test Video model .fromJson Constructor', () {
      final video = VideoModel.fromJson(
        json: {
          "id": "id",
          "title": "title",
          "description": "description",
          "fileUrl": "fileUrl",
          "thumbnailUrl": "thumbnailUrl",
          "creatorUid": "creatorUid",
          "creatorName": "creatorName",
          "likes": 1,
          "comments": 1,
          "createdAt": 1,
        },
        videoId: 'videoId',
      );

      expect(video.title, "title");
      expect(video.id, "videoId");
      expect(video.creatorName, "creatorName");
    });

    test('Test Video model .toJson Constructor', () {
      final video = VideoModel(
        id: "id",
        title: "title",
        description: "description",
        fileUrl: "fileUrl",
        thumbnailUrl: "thumbnailUrl",
        creatorUid: "creatorUid",
        creatorName: "creatorName",
        likes: 1,
        comments: 1,
        createdAt: 1,
      );

      final json = video.toJson();

      expect(json['id'], "id");
      expect(json['title'], "title");
      expect(json['creatorName'], "creatorName");
    });
  });

}
