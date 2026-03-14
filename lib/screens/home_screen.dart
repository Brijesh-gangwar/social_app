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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedController>().loadInitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    final feed = context.watch<FeedController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(),
      body: feed.isLoading
          ? const ShimmerFeed()
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: feed.posts.length + 1 + (feed.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return StoriesTray(stories: feed.stories);
                }

                final postIndex = index - 1;
                if (postIndex >= feed.posts.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (postIndex >= feed.posts.length - 2) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<FeedController>().loadNextPage();
                  });
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label coming soon'),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
