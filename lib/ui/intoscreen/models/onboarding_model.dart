class OnboardingModel {
  final String lightImage;
  final String darkImage;
  final String skipBottom;
  final String title;
  final String description;
  final String textBottom;

  OnboardingModel({
    required this.lightImage,
    required this.darkImage,
    required this.title,
    required this.description,
    required this.skipBottom,
    required this.textBottom,
  });

  static final List<OnboardingModel> boards = [
    OnboardingModel(
      lightImage: 'hot-trending1_white.png',
      darkImage: 'hot-trending_dark.png',
      title: 'findEventsThatInspireYou',
      description: 'findEventsThatInspireYouDescription',
      skipBottom: 'skip_button',
      textBottom: 'next_button',
    ),
    OnboardingModel(
      lightImage: 'being-creative_white.png',
      darkImage: 'being-creative_dark.png',
      title: 'effortless_event_planning_title',
      description: 'effortless_event_planning_description',
      skipBottom: 'skip_button',
      textBottom: 'next_button',
    ),
    OnboardingModel(
      lightImage: 'being-creative2_white.png',
      darkImage: 'being-creative2_dark.png',
      title: 'connect_with_friends_title',
      description: 'connect_with_friends_description',
      skipBottom: 'skip_button',
      textBottom: 'letsStart',
    ),
  ];
  
}
