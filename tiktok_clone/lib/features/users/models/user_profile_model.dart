class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final bool hasAvatar;
  final String avatarUrl; // 추가됨

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
    required this.hasAvatar,
    required this.avatarUrl, // 추가됨
  });

  UserProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        bio = '',
        link = '',
        hasAvatar = false,
        avatarUrl = ''; // 기본값 추가

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'link': link,
      'hasAvatar': hasAvatar,
      'avatarUrl': avatarUrl, // 추가됨
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      bio: json['bio'],
      link: json['link'],
      hasAvatar: json['hasAvatar'] ?? false,
      avatarUrl: json['avatarUrl'] ?? '', // 추가됨
    );
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    bool? hasAvatar,
    String? avatarUrl, // 추가됨
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      hasAvatar: hasAvatar ?? this.hasAvatar,
      avatarUrl: avatarUrl ?? this.avatarUrl, // 추가됨
    );
  }
}