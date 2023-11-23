

class CurrentUser {
  final String? uid;

  CurrentUser({
    this.uid,
  });
}

class UserData {
  UserData({
    required this.uid,
    required this.name,
    required this.email,

  });

  final String uid;
  final String name;
  final String email;

}
