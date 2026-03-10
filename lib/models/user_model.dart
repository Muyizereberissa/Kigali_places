class AppUser {
  final String uid;
  final String email;

  AppUser({
    required this.uid,
    required this.email,
  });

  factory AppUser.fromMap(Map<String, dynamic> data, String id) {
    return AppUser(
      uid: id,
      email: data['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
    };
  }
}