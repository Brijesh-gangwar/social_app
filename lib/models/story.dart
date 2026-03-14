import 'user_profile.dart';

class Story {
  const Story({
    required this.user,
    this.isViewed = false,
  });

  final UserProfile user;
  final bool isViewed;
}
