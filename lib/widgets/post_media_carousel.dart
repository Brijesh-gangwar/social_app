import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'pinch_to_zoom.dart';

class PostMediaCarousel extends StatefulWidget {
  const PostMediaCarousel({super.key, required this.mediaUrls});

  final List<String> mediaUrls;

  @override
  State<PostMediaCarousel> createState() => _PostMediaCarouselState();
}

class _PostMediaCarouselState extends State<PostMediaCarousel> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCarousel = widget.mediaUrls.length > 1;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: isCarousel
              ? PageView.builder(
                  controller: _pageController,
                  itemCount: widget.mediaUrls.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildImage(widget.mediaUrls[index]);
                  },
                )
              : _buildImage(widget.mediaUrls.first),
        ),
        if (isCarousel)
          Positioned(
            bottom: 12,
            child: _DotIndicator(
              count: widget.mediaUrls.length,
              index: _currentIndex,
            ),
          ),
      ],
    );
  }

  Widget _buildImage(String url) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
        final cacheSize = (constraints.maxWidth * devicePixelRatio).round();
        final cacheDimension = cacheSize > 0 ? cacheSize : null;
        final imageProvider = CachedNetworkImageProvider(url);

        return PinchToZoom(
          overlayBuilder: (context) => Image(
            image: imageProvider,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            memCacheWidth: cacheDimension,
            memCacheHeight: cacheDimension,
            placeholder: (context, url) => Container(
              color: Colors.grey.shade200,
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image_outlined),
            ),
          ),
        );
      },
    );
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(count, (dotIndex) {
          final isActive = dotIndex == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: isActive ? 8 : 6,
            height: isActive ? 8 : 6,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white70,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
