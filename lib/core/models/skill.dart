class Skill {
  final String iconPath;
  final String name;
  final String url;
  bool isHover;

  Skill({
    required this.iconPath,
    required this.name,
    required this.url,
    this.isHover = false,
  });
}
