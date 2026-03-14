import 'dart:math';

import '../models/post.dart';
import '../models/story.dart';
import 'mock_data.dart';

class PostRepository {
  PostRepository({Random? random}) : _random = random ?? Random();

  final Random _random;
  final List<PostSeed> _seeds = MockData.seeds();

  Future<List<Story>> fetchStories() async {
    return MockData.buildStories();
  }

  Future<List<Post>> fetchPage({required int page, int pageSize = 10}) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    return List.generate(pageSize, (index) {
      final seedIndex = (page * pageSize + index) % _seeds.length;
      final seed = _seeds[seedIndex];
      final createdAt = DateTime.now().subtract(Duration(
        minutes: 12 * (page * pageSize + index + 1),
      ));
      final likeBoost = _random.nextInt(120);

      return seed.toPost(
        id: 'post_${page}_$index',
        createdAt: createdAt,
      ).copyWith(
        likeCount: seed.likeCount + likeBoost,
        commentCount: seed.commentCount + _random.nextInt(20),
      );
    });
  }
}
