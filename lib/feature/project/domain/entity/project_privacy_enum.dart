enum ProjectPrivacy {
  private(str: "private"),
  publicRead(str: "public_read"),
  publicEdit(str: "public_edit");

  final String str;

  const ProjectPrivacy({required this.str});

  factory ProjectPrivacy.fromString(String str) {
    return ProjectPrivacy.values.firstWhere(
      (value) => value.str == str,
      orElse: () => ProjectPrivacy.private,
    );
  }
}
