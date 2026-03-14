import 'package:flutter/material.dart';

import 'shimmer_post_card.dart';
import 'shimmer_story.dart';

class ShimmerFeed extends StatelessWidget {
  const ShimmerFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => const ShimmerStory(),
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemCount: 6,
          ),
        ),
        const ShimmerPostCard(),
        const ShimmerPostCard(),
        const ShimmerPostCard(),
      ],
    );
  }
}
