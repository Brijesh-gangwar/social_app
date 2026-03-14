# instagram_clone

Instagram home feed UI/UX challenge implementation.

## State Management
This project uses `provider` with a `ChangeNotifier` (`FeedController`) to manage the feed state, pagination, and local interactions (like/save). The UI listens to updates and rebuilds only where needed.

## How To Run
1. Run `flutter pub get` to install dependencies.
2. Run `flutter run` to launch on a simulator or device.

## Features Covered
- Pixel-aligned home feed layout with stories tray and post feed.
- Carousel posts with dot indicators.
- Pinch-to-zoom overlay that animates back on release.
- Local toggle states for Like and Save.
- Custom snackbars for unavailable actions.
- Mock repository with 1.5s latency and shimmer loading states.
- Infinite scroll pagination (loads when two posts remain).
- Cached network images and graceful error placeholders.
