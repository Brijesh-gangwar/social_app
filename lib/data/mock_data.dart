import '../models/post.dart';
import '../models/story.dart';
import '../models/user_profile.dart';

class MockData {
  static const List<UserProfile> users = [
    UserProfile(
      id: 'u1',
      username: 'aurora.n',
      avatarUrl: 'https://i.pravatar.cc/150?img=11',
    ),
    UserProfile(
      id: 'u2',
      username: 'marco.lens',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
    ),
    UserProfile(
      id: 'u3',
      username: 'sienna.wav',
      avatarUrl: 'https://i.pravatar.cc/150?img=32',
    ),
    UserProfile(
      id: 'u4',
      username: 'studio.ash',
      avatarUrl: 'https://i.pravatar.cc/150?img=15',
    ),
    UserProfile(
      id: 'u5',
      username: 'kian.drift',
      avatarUrl: 'https://i.pravatar.cc/150?img=52',
    ),
    UserProfile(
      id: 'u6',
      username: 'elena.j',
      avatarUrl: 'https://i.pravatar.cc/150?img=48',
    ),
    UserProfile(
      id: 'u7',
      username: 'nova.park',
      avatarUrl: 'https://i.pravatar.cc/150?img=68',
    ),
    UserProfile(
      id: 'u8',
      username: 'atlas.ink',
      avatarUrl: 'https://i.pravatar.cc/150?img=21',
    ),
  ];

  static List<Story> buildStories() {
    return users
        .map((user) => Story(user: user, isViewed: user.id == 'u6'))
        .toList();
  }

  static List<PostSeed> seeds() {
    return [
      PostSeed(
        user: users[1],
        caption: 'Golden hour over the ridge.',
        likeCount: 1280,
        commentCount: 42,
        mediaUrls: [
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[2],
        caption: 'Weekend textures and slow coffee.',
        likeCount: 894,
        commentCount: 31,
        mediaUrls: [
          'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=1080&q=80',
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=1080&q=80',
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[0],
        caption: 'City lights, soft rain.',
        likeCount: 2104,
        commentCount: 67,
        mediaUrls: [
          'https://images.unsplash.com/photo-1499346030926-9a72daac6c63?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[4],
        caption: 'A quiet corner of the studio.',
        likeCount: 764,
        commentCount: 18,
        mediaUrls: [
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=1080&q=80',
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[6],
        caption: 'Soft neutrals and natural light.',
        likeCount: 1560,
        commentCount: 53,
        mediaUrls: [
          'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[3],
        caption: 'Details that make the space.',
        likeCount: 990,
        commentCount: 29,
        mediaUrls: [
          'https://images.unsplash.com/photo-1452626038306-9aae5e071dd3?auto=format&fit=crop&w=1080&q=80',
          'https://images.unsplash.com/photo-1454165205744-3b78555e5572?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[7],
        caption: 'Blue hour on the coast.',
        likeCount: 1348,
        commentCount: 40,
        mediaUrls: [
          'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[5],
        caption: 'Editing the next campaign.',
        likeCount: 602,
        commentCount: 19,
        mediaUrls: [
          'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[2],
        caption: 'Frames from the morning walk.',
        likeCount: 1102,
        commentCount: 22,
        mediaUrls: [
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1080&q=80',
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[1],
        caption: 'Minimal lines, maximum calm.',
        likeCount: 714,
        commentCount: 16,
        mediaUrls: [
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[3],
        caption: 'Color study: rust + teal.',
        likeCount: 1806,
        commentCount: 58,
        mediaUrls: [
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=1080&q=80',
          'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?auto=format&fit=crop&w=1080&q=80',
          'https://images.unsplash.com/photo-1454165205744-3b78555e5572?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
      PostSeed(
        user: users[6],
        caption: 'Morning light in soft focus.',
        likeCount: 1214,
        commentCount: 44,
        mediaUrls: [
          'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=1080&q=80',
        ],
      ),
    ];
  }
}

class PostSeed {
  const PostSeed({
    required this.user,
    required this.mediaUrls,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
  });

  final UserProfile user;
  final List<String> mediaUrls;
  final String caption;
  final int likeCount;
  final int commentCount;

  Post toPost({required String id, required DateTime createdAt}) {
    return Post(
      id: id,
      user: user,
      mediaUrls: mediaUrls,
      caption: caption,
      likeCount: likeCount,
      commentCount: commentCount,
      createdAt: createdAt,
    );
  }
}
