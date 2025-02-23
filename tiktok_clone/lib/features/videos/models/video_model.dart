class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String creatorUid;
  final String creatorName;
  final String id;
  final int likes;
  final int comments;
  final int createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.creatorUid,
    required this.creatorName,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'thumbnailUrl': thumbnailUrl,
      'creatorUid': creatorUid,
      'creatorName': creatorName,
      'likes': likes,
      'comments': comments,
      'createdAt': createdAt,
    };
  }

  factory VideoModel.fromJson({required Map<String, dynamic> json, required String videoId}) {
    return VideoModel(
      id: videoId,
      title: json['title'],
      description: json['description'],
      fileUrl: json['fileUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      creatorUid: json['creatorUid'],
      creatorName: json['creatorName'],
      likes: json['likes'],
      comments: json['comments'],
      createdAt: json['createdAt'],
    );
  }
}