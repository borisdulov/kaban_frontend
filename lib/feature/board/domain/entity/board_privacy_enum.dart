enum BoardPrivacy {
  private(str: "private"),
  publicRead(str: "public_read"),
  publicEdit(str: "public_edit");

  final String str;

  const BoardPrivacy({required this.str});

  factory BoardPrivacy.fromString(String str) {
    return BoardPrivacy.values.firstWhere(
      (value) => value.str == str,
      orElse: () => BoardPrivacy.private,
    );
  }
}
