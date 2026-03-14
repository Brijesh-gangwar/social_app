import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  const PostActions({
    super.key,
    required this.isLiked,
    required this.isSaved,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onSave,
  });

  final bool isLiked;
  final bool isSaved;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onLike,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? const Color(0xFFED4956) : Colors.black,
          ),
        ),
        IconButton(
          onPressed: onComment,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          icon: const Icon(Icons.mode_comment_outlined),
        ),
        IconButton(
          onPressed: onShare,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          icon: const Icon(Icons.send_outlined),
        ),
        const Spacer(),
        IconButton(
          onPressed: onSave,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_border,
          ),
        ),
      ],
    );
  }
}
