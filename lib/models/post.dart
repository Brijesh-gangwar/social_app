import 'user_profile.dart';

class Post {
  const Post({
    required this.id,
    required this.user,
    required this.mediaUrls,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    this.isLiked = false,
    this.isSaved = false,
  });

  final String id;
  final UserProfile user;
  final List<String> mediaUrls;
  final String caption;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;
  final bool isLiked;
  final bool isSaved;

  Post copyWith({
    String? id,
    UserProfile? user,
    List<String>? mediaUrls,
    String? caption,
    int? likeCount,
    int? commentCount,
    DateTime? createdAt,
    bool? isLiked,
    bool? isSaved,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      caption: caption ?? this.caption,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
