import 'package:flutter/foundation.dart';

import '../data/post_repository.dart';
import '../models/post.dart';
import '../models/story.dart';

class FeedController extends ChangeNotifier {
  FeedController({PostRepository? repository})
      : _repository = repository ?? PostRepository();

  final PostRepository _repository;

  final List<Post> _posts = [];
  final List<Story> _stories = [];

  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _page = 0;
  final int _pageSize = 10;

  List<Post> get posts => List.unmodifiable(_posts);
  List<Story> get stories => List.unmodifiable(_stories);
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  Future<void> loadInitial() async {
    if (!_isLoading) {
      _isLoading = true;
      notifyListeners();
    }

    _page = 0;
    _hasMore = true;
    _posts.clear();
    _stories.clear();

    final results = await Future.wait([
      _repository.fetchStories(),
      _repository.fetchPage(page: _page, pageSize: _pageSize),
    ]);

    _stories.addAll(results[0] as List<Story>);
    _posts.addAll(results[1] as List<Post>);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadNextPage() async {
    if (_isLoadingMore || !_hasMore) {
      return;
    }

    _isLoadingMore = true;
    notifyListeners();

    _page += 1;
    final nextPage = await _repository.fetchPage(page: _page, pageSize: _pageSize);

    if (nextPage.isEmpty) {
      _hasMore = false;
    } else {
      _posts.addAll(nextPage);
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  void toggleLike(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index == -1) return;

    final post = _posts[index];
    final nextLiked = !post.isLiked;

    _posts[index] = post.copyWith(
      isLiked: nextLiked,
      likeCount: post.likeCount + (nextLiked ? 1 : -1),
    );
    notifyListeners();
  }

  void toggleSave(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index == -1) return;

    final post = _posts[index];
    _posts[index] = post.copyWith(isSaved: !post.isSaved);
    notifyListeners();
  }
}
