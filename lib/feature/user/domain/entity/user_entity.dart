abstract interface class User {
  String get id;
  String get email;
  String get username;
  String get avatar;
  List<String> get teamsIds;
  List<String> get projectsIds; 
  //* List<Team> get teams;
  //* List<Project> get projects;
}