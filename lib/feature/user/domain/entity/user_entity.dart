abstract interface class User {
  String get id;
  String? get email;
  String get login;
  String? get username;
  String? get bio;
  String? get avatar;
  List<String>? get projectsIds;
}
