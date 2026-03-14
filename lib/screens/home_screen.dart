import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/feed_controller.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/post_card.dart';
import '../widgets/shimmer_feed.dart';
import '../widgets/stories_tray.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedController>().loadInitial();
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;

    final feed = context.read<FeedController>();
    if (feed.isLoading || feed.isLoadingMore || !feed.hasMore) {
      return;
    }

    if (_scrollController.position.extentAfter < 900) {
      feed.loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final feed = context.watch<FeedController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(),
      body: feed.isLoading
          ? const ShimmerFeed()
          : feed.hasError
              ? _buildErrorState(
                  message: feed.errorMessage ?? 'Something went wrong.',
                  onRetry: () => feed.loadInitial(),
                )
              : feed.posts.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      cacheExtent: 1200,
                      itemCount: feed.posts.length +
                          1 +
                          ((feed.isLoadingMore || feed.pagingError != null) ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return StoriesTray(stories: feed.stories);
                        }

                        final postIndex = index - 1;
                        if (postIndex >= feed.posts.length) {
                          if (feed.pagingError != null) {
                            return _buildPagingError(
                              message: feed.pagingError!,
                              onRetry: () => feed.loadNextPage(),
                            );
                          }
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: ShimmerFeedFooter(),
                          );
                        }

                        final post = feed.posts[postIndex];

                        return PostCard(
                          post: post,
                          onLike: () => context.read<FeedController>().toggleLike(post.id),
                          onSave: () => context.read<FeedController>().toggleSave(post.id),
                          onComment: () => _showUnavailable(context, 'Comments'),
                          onShare: () => _showUnavailable(context, 'Share'),
                        );
                      },
                    ),
    );
  }

  void _showUnavailable(BuildContext context, String label) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('$label coming soon'),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildErrorState({
    required String message,
    required VoidCallback onRetry,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 40, color: Colors.black54),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagingError({
    required String message,
    required VoidCallback onRetry,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: OutlinedButton(
        onPressed: onRetry,
        child: Text('Retry loading more: $message'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text('No posts yet'),
    );
  }
}
