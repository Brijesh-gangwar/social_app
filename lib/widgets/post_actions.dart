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
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? const Color(0xFFED4956) : Colors.black,
          ),
        ),
        IconButton(
          onPressed: onComment,
          icon: const Icon(Icons.mode_comment_outlined),
        ),
        IconButton(
          onPressed: onShare,
          icon: const Icon(Icons.send_outlined),
        ),
        const Spacer(),
        IconButton(
          onPressed: onSave,
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_border,
          ),
        ),
      ],
    );
  }
}
