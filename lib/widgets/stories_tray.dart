import 'package:flutter/material.dart';

import '../models/story.dart';
import 'story_avatar.dart';

class StoriesTray extends StatelessWidget {
  const StoriesTray({super.key, required this.stories});

  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 0.6),
        ),
      ),
      child: SizedBox(
        height: 110,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => StoryAvatar(story: stories[index]),
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemCount: stories.length,
        ),
      ),
    );
  }
}
