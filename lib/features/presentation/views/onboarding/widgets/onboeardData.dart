class Onboard{
  final String image, title, description;
  Onboard({required this.image, required this.title, required this.description});

}
final List<Onboard> demoData = [
  Onboard(
      image: 'assets/images/onboarding1.json',
      title: "Message Me",
      description: "The world's fastest messaging app.\n it's free & secure."
  ),
  Onboard(
      image: 'assets/images/onboarding2.json',
      title: "Fast",
      description: "Message Me delivers messages\nfaster than any other application."
  ),
  Onboard(
      image: 'assets/images/onboarding3.json',
      title: "Free",
      description: "Message Me provide free unlimited\ncloud storage for chats and media."
  ),
  Onboard(
      image: 'assets/images/onboarding4.json',
      title: "Powerful",
      description: "Message Me has no limits on\nthe size of your media and chats."
  ),
  Onboard(
      image: 'assets/images/onboarding5.json',
      title: "Secure",
      description: "Message Me keeps your messages\nsafe from hackers attacks."
  ),

];