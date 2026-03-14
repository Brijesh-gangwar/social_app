# instagram_clone

Instagram home feed UI/UX challenge implementation focused on a pixel-accurate layout, smooth interactions, and clean architecture.

## Overview
This app replicates the Instagram Home Feed with a stories tray, post feed, carousel posts, and touch interactions. It uses a mock repository with simulated latency so loading states and pagination can be demonstrated realistically.

## Features Covered
- Top bar with logo and action icons.
- Stories tray with ring gradients and usernames.
- Post feed with headers, media, actions, captions, and metadata.
- Carousel posts with dot indicators.
- Pinch-to-zoom overlay that scales over the UI and animates back on release.
- Local toggle states for Like and Save.
- Custom snackbars for unimplemented actions.
- Shimmer loading state for initial load and pagination.
- Infinite scroll pagination.
- Cached network images with error placeholders.

## State Management
`provider` + `ChangeNotifier` is used for a simple, testable state layer:
- `FeedController` owns the feed state (loading, paging, errors, likes/saves).
- UI listens via `context.watch` and dispatches actions with `context.read`.
- This keeps widgets focused on rendering while business logic stays centralized.

## Data Flow
`PostRepository` simulates network latency and returns mock data. `FeedController` requests pages and stories, updates state, and notifies listeners. The UI renders based on that state and shows loading or error UI when appropriate.

## How To Run / Build
1. Run `flutter pub get` to install dependencies.
2. Run `flutter run` to launch on a simulator or device.
3. Optional build: `flutter build apk` (Android) or `flutter build ios` (iOS).

## Folder Structure
```text
instagram_clone/
├─ lib/
│  ├─ data/
│  │  ├─ mock_data.dart
│  │  └─ post_repository.dart
│  ├─ models/
│  │  ├─ post.dart
│  │  ├─ story.dart
│  │  └─ user_profile.dart
│  ├─ providers/
│  │  └─ feed_controller.dart
│  ├─ screens/
│  │  └─ home_screen.dart
│  ├─ widgets/
│  │  ├─ app_top_bar.dart
│  │  ├─ pinch_to_zoom.dart
│  │  ├─ post_actions.dart
│  │  ├─ post_card.dart
│  │  ├─ post_media_carousel.dart
│  │  ├─ shimmer_feed.dart
│  │  ├─ shimmer_post_card.dart
│  │  ├─ shimmer_story.dart
│  │  ├─ stories_tray.dart
│  │  └─ story_avatar.dart
│  └─ main.dart
├─ test/
│  └─ widget_test.dart
├─ pubspec.yaml
└─ README.md
```
