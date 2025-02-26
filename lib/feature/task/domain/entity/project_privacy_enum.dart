enum ProjectPrivacy {
  private(str: "private"),      
  public(str: "public"),        
  edit(str: "edit"); 
  
  final String str;
  
  const ProjectPrivacy({required this.str});
  
  factory ProjectPrivacy.fromString(String str) {
    return ProjectPrivacy.values.firstWhere(
      (value) => value.str == str,
      orElse: () => ProjectPrivacy.private,
    );
  }
}