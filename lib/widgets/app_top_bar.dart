import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    const iconSize = 24.0;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: false,
      titleSpacing: 16,
      toolbarHeight: 56,
      title: Text(
        'Instagram',
        style: GoogleFonts.grandHotel(
          color: Colors.black,
          fontSize: 32,
          height: 1.1,
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Notifications',
          iconSize: iconSize,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          constraints: const BoxConstraints(minHeight: 40, minWidth: 40),
          icon: const Icon(Icons.favorite_border),
          onPressed: () => _showUnavailable(context, 'Notifications'),
        ),
        IconButton(
          tooltip: 'Messages',
          iconSize: iconSize,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          constraints: const BoxConstraints(minHeight: 40, minWidth: 40),
          icon: const Icon(Icons.send_outlined),
          onPressed: () => _showUnavailable(context, 'Messages'),
        ),
        const SizedBox(width: 6),
      ],
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
}
