class Skill {
  final String iconPath;
  final String name;
  bool isHover;

  Skill({
    required this.iconPath,
    required this.name,
    this.isHover = false,
  });
}
