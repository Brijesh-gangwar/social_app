import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      titleSpacing: 16,
      title: Text(
        'Instagram',
        style: GoogleFonts.grandHotel(
          color: Colors.black,
          fontSize: 34,
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Notifications',
          icon: const Icon(Icons.favorite_border),
          onPressed: () => _showUnavailable(context, 'Notifications'),
        ),
        IconButton(
          tooltip: 'Messages',
          icon: const Icon(Icons.send_outlined),
          onPressed: () => _showUnavailable(context, 'Messages'),
        ),
        const SizedBox(width: 4),
      ],
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
